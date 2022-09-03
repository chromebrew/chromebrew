require 'package'

class Openjdk11 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'https://openjdk.org/'
  version '11.0.16.1'
  license 'GPL-2'
  compatibility 'all'
  source_url({
    aarch64: 'https://cdn.azul.com/zulu-embedded/bin/zulu11.58.25-ca-jdk11.0.16.1-linux_aarch32hf.tar.gz',
     armv7l: 'https://cdn.azul.com/zulu-embedded/bin/zulu11.58.25-ca-jdk11.0.16.1-linux_aarch32hf.tar.gz',
       i686: 'https://cdn.azul.com/zulu/bin/zulu11.58.25-ca-jdk11.0.16.1-linux_i686.tar.gz',
     x86_64: 'https://cdn.azul.com/zulu/bin/zulu11.58.23-ca-jdk11.0.16.1-linux_x64.tar.gz'
  })
  source_sha256({
    aarch64: '6f7a4721303710384e7c9aeaf5a47954dbf992e2d92a27bc83c2170229c3a826',
     armv7l: '6f7a4721303710384e7c9aeaf5a47954dbf992e2d92a27bc83c2170229c3a826',
       i686: 'c75d2bd5f53d92ca3aed24ffdef6690824af5a7e04f8809dcc509b0a666c3083',
     x86_64: 'b8b3e7c2eec6d62b6f4de3e4b4b1c6035d42bd4d6d4f31e9aa804dc311d4a4b3'
  })

  no_compile_needed

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
    FileUtils.mv 'bin/', CREW_DEST_PREFIX
    FileUtils.mv 'conf/', "#{CREW_DEST_PREFIX}/share/openjdk11"
    FileUtils.mv 'jmods/', "#{CREW_DEST_PREFIX}/share/openjdk11"
    FileUtils.mv 'include/', CREW_DEST_PREFIX
    FileUtils.mv 'lib/', CREW_DEST_PREFIX
    FileUtils.mv Dir['man/*'], CREW_DEST_MAN_PREFIX
  end
end
