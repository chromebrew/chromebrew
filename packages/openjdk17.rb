require 'package'

class Openjdk17 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'https://openjdk.org/'
  version '17.36.19'
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
  no_fhs

  def self.preflight
    jdkver = `java -version 2>&1 | head -1 | cut -d'"' -f2`.chomp
    unless jdkver.empty? || jdkver.include?('No such file or directory') || jdkver.include?('not found')
      majver = `java -version 2>&1 | head -1 | cut -d'"' -f2 | cut -d'.' -f1`.chomp
      majver = '17' if majver == '1'
      puts "Package jdk#{majver} already installed.".lightgreen
      abort "Enter `crew remove jdk#{majver} && crew install openjdk8` to install this version."
    end
  end

  def self.install
    FileUtils.mkdir_p CREW_DEST_MAN_PREFIX
    FileUtils.cp_r 'bin/', CREW_DEST_PREFIX
    FileUtils.cp_r 'include/', CREW_DEST_PREFIX
    FileUtils.cp_r 'jre/', CREW_DEST_PREFIX
    FileUtils.cp_r 'lib/', CREW_DEST_PREFIX
    FileUtils.cp_r Dir['man/*'], CREW_DEST_MAN_PREFIX
  end
end
