require 'package'

class Openjdk8 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'https://openjdk.org/'
  version '1.8.0_432'
  license 'GPL-2'
  compatibility 'all'
  # Visit https://www.azul.com/downloads/?version=java-8-lts&package=jdk#zulu to download the binaries.
  source_url({
    aarch64: 'https://cdn.azul.com/zulu-embedded/bin/zulu8.82.0.23-ca-jdk8.0.432-linux_aarch32hf.tar.gz',
     armv7l: 'https://cdn.azul.com/zulu-embedded/bin/zulu8.82.0.23-ca-jdk8.0.432-linux_aarch32hf.tar.gz',
       i686: 'https://cdn.azul.com/zulu/bin/zulu8.82.0.21-ca-jdk8.0.432-linux_i686.tar.gz',
     x86_64: 'https://cdn.azul.com/zulu/bin/zulu8.82.0.21-ca-jdk8.0.432-linux_x64.tar.gz'
  })
  source_sha256({
    aarch64: '958e0ce5f1ec916111143da365e89bb0cff27251f0150a5e7fc2653c19ce5f6d',
     armv7l: '958e0ce5f1ec916111143da365e89bb0cff27251f0150a5e7fc2653c19ce5f6d',
       i686: 'b5358cebc351d859077819d69411e91f15d75654afadb361e31962472cbebc49',
     x86_64: 'cc3dc7883441a38d910333a9417d8123b0973a86a08828242299a16157c272c0'
  })

  no_compile_needed
  no_shrink
  no_fhs

  def self.preflight
    jdkver = `java -version 2>&1`[/version "(.*?)"/, 1].to_s
    unless jdkver.empty? || jdkver.include?('No such file or directory') || jdkver.include?('not found')
      jdkname = `java -version 2>&1`[/(.*?)\s/, 1].to_s
      jdkname = 'jdk' if jdkname == 'java'
      majver = jdkver[/(\d+)\./, 1].to_s
      majver = '8' if majver == '1'
      unless jdkname == 'openjdk' && majver == '8'
        puts "Package #{jdkname}#{majver} already installed.".lightgreen
        abort "Enter `crew remove #{jdkname}#{majver} && crew install openjdk8` to install this version."
      end
    end
  end

  def self.install
    FileUtils.mkdir_p CREW_DEST_MAN_PREFIX
    FileUtils.mv 'bin/', CREW_DEST_PREFIX
    FileUtils.mv 'include/', CREW_DEST_PREFIX
    FileUtils.mv 'jre/', CREW_DEST_PREFIX
    FileUtils.mv 'lib/', CREW_DEST_PREFIX
    FileUtils.mv Dir['man/*'], CREW_DEST_MAN_PREFIX

    # Make sure symlinks to all binaries exist.
    Dir["#{CREW_DEST_PREFIX}/bin/*"].each do |bin|
      bin = File.basename(bin)
      FileUtils.ln_s "#{CREW_PREFIX}/bin/#{bin}", "#{CREW_DEST_PREFIX}/jre/bin/#{bin}" unless File.exist? "#{CREW_DEST_PREFIX}/jre/bin/#{bin}"
    end

    # Add environment variable.
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    javaenv = <<~EOF
      # Java configuration
      export JAVA_HOME=#{CREW_PREFIX}/jre
    EOF
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/10-openjdk8", javaenv)
  end
end
