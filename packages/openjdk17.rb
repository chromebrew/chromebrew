require 'package'

class Openjdk17 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'https://openjdk.org/'
  version '17.0.8'
  license 'GPL-2'
  compatibility 'all'
  source_url({
    aarch64: 'https://cdn.azul.com/zulu-embedded/bin/zulu17.44.15-ca-jdk17.0.8-linux_aarch32hf.tar.gz',
     armv7l: 'https://cdn.azul.com/zulu-embedded/bin/zulu17.44.15-ca-jdk17.0.8-linux_aarch32hf.tar.gz',
       i686: 'https://cdn.azul.com/zulu/bin/zulu17.44.15-ca-jdk17.0.8-linux_i686.tar.gz',
     x86_64: 'https://cdn.azul.com/zulu/bin/zulu17.44.15-ca-jdk17.0.8-linux_x64.tar.gz'
  })
  source_sha256({
    aarch64: '4feb1f6cba26c66160e03284b876071ee9d27954df2e2be51def935afc30d8d9',
     armv7l: '4feb1f6cba26c66160e03284b876071ee9d27954df2e2be51def935afc30d8d9',
       i686: 'bc84c25f53f6961c5649f1fd363e944d48113ead07020ba90a2b3d53cea1b5eb',
     x86_64: '423d1f40e0cbe873f357cebb95b19a59503948ee3c91639ecbc8e64df6a6f5fc'
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
