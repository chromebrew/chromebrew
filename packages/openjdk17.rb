require 'package'

class Openjdk17 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'https://openjdk.org/'
  version '17.0.7'
  license 'GPL-2'
  compatibility 'all'
  source_url({
    aarch64: 'https://cdn.azul.com/zulu-embedded/bin/zulu17.42.19-ca-jdk17.0.7-linux_aarch32hf.tar.gz',
     armv7l: 'https://cdn.azul.com/zulu-embedded/bin/zulu17.42.19-ca-jdk17.0.7-linux_aarch32hf.tar.gz',
       i686: 'https://cdn.azul.com/zulu/bin/zulu17.42.19-ca-jdk17.0.7-linux_i686.tar.gz',
     x86_64: 'https://cdn.azul.com/zulu/bin/zulu17.42.19-ca-jdk17.0.7-linux_x64.tar.gz'
  })
  source_sha256({
    aarch64: '25f48e8d4a339f7346eb7884fa0c040911c86113b361a0c6787d28627cae09c2',
     armv7l: '25f48e8d4a339f7346eb7884fa0c040911c86113b361a0c6787d28627cae09c2',
       i686: '53a66b711d828deae801870143b00be2cf4563ce283d393b08b7b96a846dabd8',
     x86_64: '28861f8292eab43290109c33e1ba7ff3776c44d043e7c8462d6c9702bf9fffe0'
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
