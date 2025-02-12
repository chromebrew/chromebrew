require 'package'

class Openjdk17 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'https://openjdk.org/'
  version '17.0.14'
  license 'GPL-2'
  compatibility 'all'
  # Visit https://www.azul.com/downloads/?version=java-17-lts&package=jdk#zulu to download the binaries.
  source_url({
    aarch64: 'https://cdn.azul.com/zulu-embedded/bin/zulu17.56.15-ca-jdk17.0.14-c2-linux_aarch32hf.tar.gz',
     armv7l: 'https://cdn.azul.com/zulu-embedded/bin/zulu17.56.15-ca-jdk17.0.14-c2-linux_aarch32hf.tar.gz',
       i686: 'https://cdn.azul.com/zulu/bin/zulu17.56.15-ca-jdk17.0.14-linux_i686.tar.gz',
     x86_64: 'https://cdn.azul.com/zulu/bin/zulu17.56.15-ca-jdk17.0.14-linux_x64.tar.gz'
  })
  source_sha256({
    aarch64: '10aab32318c55bf083c5f873818e3e33300815b8d81487d3433e890155d02be7',
     armv7l: '10aab32318c55bf083c5f873818e3e33300815b8d81487d3433e890155d02be7',
       i686: '28d4797a883d886b00eb0c7225267920c51ccafec93d699427eca4feb138c63a',
     x86_64: '37ab75b2f5da0ff0db973b31e9d9f14f729137a0a110abd6472ac8c6f2feabb6'
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
