require 'package'

class Openjdk17 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'https://openjdk.org/'
  version '17.0.6'
  license 'GPL-2'
  compatibility 'all'
  source_url({
    aarch64: 'https://cdn.azul.com/zulu-embedded/bin/zulu17.40.19-ca-jdk17.0.6-linux_aarch32hf.tar.gz',
     armv7l: 'https://cdn.azul.com/zulu-embedded/bin/zulu17.40.19-ca-jdk17.0.6-linux_aarch32hf.tar.gz',
       i686: 'https://cdn.azul.com/zulu/bin/zulu17.40.19-ca-jdk17.0.6-linux_i686.tar.gz',
     x86_64: 'https://cdn.azul.com/zulu/bin/zulu17.40.19-ca-jdk17.0.6-linux_x64.tar.gz'
  })
  source_sha256({
    aarch64: 'a2d9d7b734174fd734700194d8e38434f24a62be193c4c2810ba1a91efd4c5e4',
     armv7l: 'a2d9d7b734174fd734700194d8e38434f24a62be193c4c2810ba1a91efd4c5e4',
       i686: '7466df603829fd075298181c2a3adb11aadffa134746b9bb96e69c44e1844a3e',
     x86_64: '2867572c5af67d7bf4c53bf9d96c35977eebdfdbf26202c2dc7a1acbbea3f6b7'
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
