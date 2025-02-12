require 'package'

class Openjdk11 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'https://openjdk.org/'
  version '11.0.26'
  license 'GPL-2'
  compatibility 'all'
  # Visit https://www.azul.com/downloads/?version=java-11-lts&package=jdk#zulu to download the binaries.
  source_url({
    aarch64: 'https://cdn.azul.com/zulu-embedded/bin/zulu11.78.15-ca-jdk11.0.26-linux_aarch32hf.tar.gz',
     armv7l: 'https://cdn.azul.com/zulu-embedded/bin/zulu11.78.15-ca-jdk11.0.26-linux_aarch32hf.tar.gz',
       i686: 'https://cdn.azul.com/zulu/bin/zulu11.78.15-ca-jdk11.0.26-linux_i686.tar.gz',
     x86_64: 'https://cdn.azul.com/zulu/bin/zulu11.78.15-ca-jdk11.0.26-linux_x64.tar.gz'
  })
  source_sha256({
    aarch64: '82c3a87f8a4425c81907c131c8594c63d1f50a767189a209e48873b75c339fde',
     armv7l: '82c3a87f8a4425c81907c131c8594c63d1f50a767189a209e48873b75c339fde',
       i686: '9b4fdfaf72bf0bee23404ce670189572b757010e3d8de2c8ba6fbc2516ecfcec',
     x86_64: 'fdf95b001d50b03bc3ce5f4fe7dc96bec9f94e561f9ec722a149bd7995600449'
  })

  no_compile_needed
  no_shrink
  print_source_bashrc

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
