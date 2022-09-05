require 'package'

class Openjdk17 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'https://openjdk.org/'
  version '17.0.4.1'
  license 'GPL-2'
  compatibility 'all'
  source_url({
    aarch64: 'https://cdn.azul.com/zulu-embedded/bin/zulu17.36.19-ca-jdk17.0.4.1-linux_aarch32hf.tar.gz',
     armv7l: 'https://cdn.azul.com/zulu-embedded/bin/zulu17.36.19-ca-jdk17.0.4.1-linux_aarch32hf.tar.gz',
       i686: 'https://cdn.azul.com/zulu/bin/zulu17.36.19-ca-jdk17.0.4.1-linux_i686.tar.gz',
     x86_64: 'https://cdn.azul.com/zulu/bin/zulu17.36.17-ca-jdk17.0.4.1-linux_x64.tar.gz'
  })
  source_sha256({
    aarch64: '93228b96f904a53495fc30d338316c488da908f54368dc0d2643255b4ebd6cef',
     armv7l: '93228b96f904a53495fc30d338316c488da908f54368dc0d2643255b4ebd6cef',
       i686: '96a3c6e70ce5eff76cc54fa67c53c6f657229f00abbaed59c15da3f7f85829af',
     x86_64: 'b3a1e74047ab3209eac8c22f991436c6c4cead3d77892d3a67a056d848aae26a'
  })

  no_compile_needed

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
    FileUtils.mv 'bin/', CREW_DEST_PREFIX
    FileUtils.mv 'conf/', "#{CREW_DEST_PREFIX}/share/openjdk17"
    FileUtils.mv 'jmods/', "#{CREW_DEST_PREFIX}/share/openjdk17"
    FileUtils.mv 'include/', CREW_DEST_PREFIX
    FileUtils.mv 'lib/', CREW_DEST_PREFIX
    FileUtils.mv Dir['man/*'], CREW_DEST_MAN_PREFIX
  end
end
