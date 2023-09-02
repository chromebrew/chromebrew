require 'package'

class Openjdk11 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'https://openjdk.org/'
  version '11.0.20'
  license 'GPL-2'
  compatibility 'all'
  source_url({
    aarch64: 'https://cdn.azul.com/zulu-embedded/bin/zulu11.66.15-ca-jdk11.0.20-linux_aarch32hf.tar.gz',
     armv7l: 'https://cdn.azul.com/zulu-embedded/bin/zulu11.66.15-ca-jdk11.0.20-linux_aarch32hf.tar.gz',
       i686: 'https://cdn.azul.com/zulu/bin/zulu11.66.15-ca-jdk11.0.20-linux_i686.tar.gz',
     x86_64: 'https://cdn.azul.com/zulu/bin/zulu11.66.15-ca-jdk11.0.20-linux_x64.tar.gz'
  })
  source_sha256({
    aarch64: '0caac5eceb50040296ddff231048ed600bdd9f7818899ca72b9e7f0175b95315',
     armv7l: '0caac5eceb50040296ddff231048ed600bdd9f7818899ca72b9e7f0175b95315',
       i686: '0589901c9311cfa570961a88717aae058b5839f3aef17bd98692f4b2e273292d',
     x86_64: 'a34b404f87a08a61148b38e1416d837189e1df7a040d949e743633daf4695a3c'
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
    FileUtils.mv 'bin/', CREW_DEST_PREFIX
    FileUtils.mv 'conf/', "#{CREW_DEST_PREFIX}/share/openjdk11"
    FileUtils.mv 'jmods/', "#{CREW_DEST_PREFIX}/share/openjdk11"
    FileUtils.mv 'include/', CREW_DEST_PREFIX
    FileUtils.mv 'lib/', CREW_DEST_PREFIX
    FileUtils.mv Dir['man/*'], CREW_DEST_MAN_PREFIX
  end
end
