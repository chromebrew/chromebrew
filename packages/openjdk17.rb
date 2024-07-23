require 'package'

class Openjdk17 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'https://openjdk.org/'
  version '17.0.11'
  license 'GPL-2'
  compatibility 'all'
  # Visit https://www.azul.com/downloads/?version=java-17-lts&package=jdk#zulu to download the binaries.
  source_url({
    aarch64: 'https://cdn.azul.com/zulu-embedded/bin/zulu17.50.19-ca-jdk17.0.11-c2-linux_aarch32hf.tar.gz',
     armv7l: 'https://cdn.azul.com/zulu-embedded/bin/zulu17.50.19-ca-jdk17.0.11-c2-linux_aarch32hf.tar.gz',
       i686: 'https://cdn.azul.com/zulu/bin/zulu17.50.19-ca-jdk17.0.11-linux_i686.tar.gz',
     x86_64: 'https://cdn.azul.com/zulu/bin/zulu17.50.19-ca-jdk17.0.11-linux_x64.tar.gz'
  })
  source_sha256({
    aarch64: '60dcdc62928e7f0eefe815ca866adc706d94a8ad014b9620d0f753cffcd6c4d0',
     armv7l: '60dcdc62928e7f0eefe815ca866adc706d94a8ad014b9620d0f753cffcd6c4d0',
       i686: '6cbbae9dc7b2c1abd5a87bfd71890456080c68004bfa722c32957f6b2c307616',
     x86_64: 'a1e8ac9ae5804b84dc07cf9d8ebe1b18247d70c92c1e0de97ea10109563f4379'
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
