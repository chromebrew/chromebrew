require 'package'

class Openjdk8 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'https://openjdk.org/'
  version %w[i686 x86_64].include?(ARCH) ? '1.8.0_502' : '1.8.0_492'
  license 'GPL-2'
  compatibility 'all'
  # Visit https://www.azul.com/downloads/?version=java-8-lts&package=jdk#zulu to download the binaries.
  # The project stopped supporting arm 32-bit with version 1.8.0_492.
  source_url({
    aarch64: 'https://cdn.azul.com/zulu/bin/zulu8.94.0.17-ca-jdk8.0.492-linux_aarch32sf.tar.gz',
     armv7l: 'https://cdn.azul.com/zulu/bin/zulu8.94.0.17-ca-jdk8.0.492-linux_aarch32sf.tar.gz',
       i686: 'https://cdn.azul.com/zulu/bin/zulu8.96.0.19-ca-jdk8.0.502-linux_i686.tar.gz',
     x86_64: 'https://cdn.azul.com/zulu/bin/zulu8.96.0.19-ca-jdk8.0.502-linux_x64.tar.gz'
  })
  source_sha256({
    aarch64: '70d6ea4fb9041e057a42fc5a3b863682e749c887d51ca949a4af1361c4c71951',
     armv7l: '70d6ea4fb9041e057a42fc5a3b863682e749c887d51ca949a4af1361c4c71951',
       i686: 'f0afe30e623593c12dafd761f15175702f0cd26d7c82f93539b3d8501f95a51a',
     x86_64: '5923daaf12fd0b87e60e437aaae7b2e5b257846cdb8ac15065258fb59a1da70a'
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
