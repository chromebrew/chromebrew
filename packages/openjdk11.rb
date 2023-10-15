require 'package'

class Openjdk11 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'https://openjdk.org/'
  version '11.0.20.1'
  license 'GPL-2'
  compatibility 'all'
  # Visit https://www.azul.com/downloads/?package=jdk#zulu to download the binaries.
  source_url({
    aarch64: 'https://cdn.azul.com/zulu-embedded/bin/zulu11.66.19-ca-jdk11.0.20.1-linux_aarch32hf.tar.gz',
     armv7l: 'https://cdn.azul.com/zulu-embedded/bin/zulu11.66.19-ca-jdk11.0.20.1-linux_aarch32hf.tar.gz',
       i686: 'https://cdn.azul.com/zulu/bin/zulu11.66.19-ca-jdk11.0.20.1-linux_i686.tar.gz',
     x86_64: 'https://cdn.azul.com/zulu/bin/zulu11.66.19-ca-jdk11.0.20.1-linux_x64.tar.gz'
  })
  source_sha256({
    aarch64: '905736ff566d7a3fcd33efa52bba77bbe38b046db8ebdb0f7e3bf5e2e8eeec7e',
     armv7l: '905736ff566d7a3fcd33efa52bba77bbe38b046db8ebdb0f7e3bf5e2e8eeec7e',
       i686: 'a8bc2ee67a5ae56cb0c792d9d0f3f299ff260926aa6c2685b363ac295731133c',
     x86_64: '7c2c50f93d460b09005bb29dd38808b4aa56e473036897f348396430764c3e98'
  })

  no_compile_needed
  no_shrink

  def self.preflight
    jdkver = `java -version 2>&1`[/version "(.*?)"/, 1].to_s
    unless jdkver.empty? || jdkver.include?('No such file or directory') || jdkver.include?('not found')
      jdkname = `java -version 2>&1`[/(.*?)\s/, 1].to_s
      jdkname = 'jdk' if jdkname == 'java'
      majver = jdkver[/(\d+)\./, 1].to_s
      majver = '8' if majver == '1'
      unless jdkname == 'openjdk' && majver == '11'
        puts "Package #{jdkname}#{majver} already installed.".lightgreen
        abort "Enter `crew remove #{jdkname}#{majver} && crew install openjdk11` to install this version."
      end
    end
  end

  def self.install
    FileUtils.mkdir_p CREW_DEST_MAN_PREFIX
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/openjdk11"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/openjdk11/"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    Dir["#{CREW_DEST_PREFIX}/share/openjdk11/bin/*"].each do |binfile|
      @basename = File.basename(binfile)
      FileUtils.ln_s "#{CREW_PREFIX}/share/openjdk11/bin/#{@basename}", "#{CREW_DEST_PREFIX}/bin/#{@basename}"
    end
    FileUtils.mv Dir["#{CREW_DEST_PREFIX}/share/openjdk11/man/*"], CREW_DEST_MAN_PREFIX
    # Add environment variable.
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    javaenv = <<~EOF
      # Java configuration
      JAVA_HOME=#{CREW_PREFIX}
    EOF
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/10-openjdk11", javaenv)
  end

  def self.postinstall
    puts "\nType 'source ~/.bashrc' to finish the installation.\n".lightblue
  end
end
