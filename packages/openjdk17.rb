require 'package'

class Openjdk17 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'https://openjdk.org/'
  version %w[i686 x86_64].include?(ARCH) ? '17.0.20' : '17.0.19'
  license 'GPL-2'
  compatibility 'all'
  # Visit https://www.azul.com/downloads/?version=java-17-lts&package=jdk#zulu to download the binaries.
  # The project stopped supporting arm 32-bit with version 17.0.19.
  source_url({
    aarch64: 'https://cdn.azul.com/zulu/bin/zulu17.66.19-ca-jdk17.0.19-c2-linux_aarch32hf.tar.gz',
     armv7l: 'https://cdn.azul.com/zulu/bin/zulu17.66.19-ca-jdk17.0.19-c2-linux_aarch32hf.tar.gz',
       i686: 'https://cdn.azul.com/zulu/bin/zulu17.68.17-ca-jdk17.0.20-linux_i686.tar.gz',
     x86_64: 'https://cdn.azul.com/zulu/bin/zulu17.68.17-ca-jdk17.0.20-linux_x64.tar.gz'
  })
  source_sha256({
    aarch64: 'bda6b8fbeb63d4be15f4d98604502fc9f08671e2ffd0c1b838f1ad1a053535dc',
     armv7l: 'bda6b8fbeb63d4be15f4d98604502fc9f08671e2ffd0c1b838f1ad1a053535dc',
       i686: 'fc51a5a4551c697a56324bf63052e76302d9491407a6bbf48a43f57a1e4f2e88',
     x86_64: '32c5efedf69f4a95635ea2923f6a6ee90ce6ca83df0bd43ba55dd662d5af429a'
  })

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
        abort "Enter `crew remove #{jdkname}#{majver} && crew install openjdk17` to install this version."
      end
    end
  end

  def self.install
    FileUtils.mkdir_p CREW_DEST_MAN_PREFIX
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/openjdk17"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/openjdk17/"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    Dir["#{CREW_DEST_PREFIX}/share/openjdk17/bin/*"].each do |binfile|
      @basename = File.basename(binfile)
      FileUtils.ln_s "#{CREW_PREFIX}/share/openjdk17/bin/#{@basename}", "#{CREW_DEST_PREFIX}/bin/#{@basename}"
    end
    FileUtils.mv Dir["#{CREW_DEST_PREFIX}/share/openjdk17/man/*"], CREW_DEST_MAN_PREFIX
    # Add environment variable.
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    javaenv = <<~EOF
      # Java configuration
      JAVA_HOME=#{CREW_PREFIX}
    EOF
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/10-openjdk17", javaenv)
  end
end
