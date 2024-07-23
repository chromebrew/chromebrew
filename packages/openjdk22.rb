require 'package'

class Openjdk22 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'https://openjdk.org/'
  version '22.0.1'
  license 'GPL-2'
  compatibility 'x86_64'
  # Visit https://www.azul.com/downloads/?package=jdk#zulu to download the binary.
  source_url 'https://cdn.azul.com/zulu/bin/zulu22.30.13-ca-jdk22.0.1-linux_x64.tar.gz'
  source_sha256 '993d91062c631d10508475f7b112724fa8136704ec1412d5cc1f93ddda1eddb0'

  no_compile_needed
  no_shrink
  print_source_bashrc

  def self.preflight
    jdkver = `java -version 2>&1`[/version "(.*?)"/, 1].to_s
    unless jdkver.empty? || jdkver.include?('No such file or directory') || jdkver.include?('not found')
      jdkname = `java -version 2>&1`[/(.*?)\s/, 1].to_s
      jdkname = 'jdk' if jdkname == 'java'
      majver = jdkver[/(\d+)\./, 1].to_s
      majver = '8' if majver == '1'
      unless jdkname == 'openjdk' && majver == '17'
        puts "Package #{jdkname}#{majver} already installed.".lightgreen
        abort "Enter `crew remove #{jdkname}#{majver} && crew install openjdk21` to install this version."
      end
    end
  end

  def self.install
    FileUtils.mkdir_p CREW_DEST_MAN_PREFIX
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/openjdk22"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/openjdk22/"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    Dir["#{CREW_DEST_PREFIX}/share/openjdk22/bin/*"].each do |binfile|
      @basename = File.basename(binfile)
      FileUtils.ln_s "#{CREW_PREFIX}/share/openjdk22/bin/#{@basename}", "#{CREW_DEST_PREFIX}/bin/#{@basename}"
    end
    FileUtils.mv Dir["#{CREW_DEST_PREFIX}/share/openjdk22/man/*"], CREW_DEST_MAN_PREFIX
    # Add environment variable.
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    javaenv = <<~EOF
      # Java configuration
      JAVA_HOME=#{CREW_PREFIX}
    EOF
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/10-openjdk22", javaenv)
  end
end
