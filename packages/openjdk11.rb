require 'package'

class Openjdk11 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'https://openjdk.org/'
  version '11.0.22'
  license 'GPL-2'
  compatibility 'all'
  # Visit https://www.azul.com/downloads/?version=java-11-lts&package=jdk#zulu to download the binaries.
  source_url({
    aarch64: 'https://cdn.azul.com/zulu-embedded/bin/zulu11.70.15-ca-jdk11.0.22-linux_aarch32hf.tar.gz',
     armv7l: 'https://cdn.azul.com/zulu-embedded/bin/zulu11.70.15-ca-jdk11.0.22-linux_aarch32hf.tar.gz',
       i686: 'https://cdn.azul.com/zulu/bin/zulu11.70.15-ca-jdk11.0.22-linux_i686.tar.gz',
     x86_64: 'https://cdn.azul.com/zulu/bin/zulu11.70.15-ca-jdk11.0.22-linux_x64.tar.gz'
  })
  source_sha256({
    aarch64: 'd354e784a533291bc8deb73613105ccd43295c714981f708315f0a11adc6f4e0',
     armv7l: 'd354e784a533291bc8deb73613105ccd43295c714981f708315f0a11adc6f4e0',
       i686: 'e48c8060de5d4c4e2c1be476fcc57f22c77df3195ecdeba3049674d9922491a7',
     x86_64: '578d5946b26d9257b78e82a1c28203e5bbd690de48e2016399b1274c3ee7a3c5'
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
end
