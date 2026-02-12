require 'package'

class Openjdk11 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'https://openjdk.org/'
  version %w[i686 x86_64].include?(ARCH) ? '11.0.30' : '11.0.29'
  license 'GPL-2'
  compatibility 'all'
  # Visit https://www.azul.com/downloads/?version=java-11-lts&package=jdk#zulu to download the binaries.
  source_url({
    aarch64: 'https://cdn.azul.com/zulu-embedded/bin/zulu11.84.17-ca-jdk11.0.29-linux_aarch32hf.tar.gz',
     armv7l: 'https://cdn.azul.com/zulu-embedded/bin/zulu11.84.17-ca-jdk11.0.29-linux_aarch32hf.tar.gz',
       i686: 'https://cdn.azul.com/zulu/bin/zulu11.86.19-ca-jdk11.0.30-linux_i686.tar.gz',
     x86_64: 'https://cdn.azul.com/zulu/bin/zulu11.86.19-ca-jdk11.0.30-linux_x64.tar.gz'
  })
  source_sha256({
    aarch64: '2b1e9764868f2f20678390b86a2c7527afc008bf53f3440788b9c1dc9b0f729e',
     armv7l: '2b1e9764868f2f20678390b86a2c7527afc008bf53f3440788b9c1dc9b0f729e',
       i686: '4a87875925a64b640f18ca9cc70baf7054d8c2642e3f749102b1ba139cb1c25c',
     x86_64: 'ac3ae99b3bedd81b672467279656a91bf34d1887ebd244e1cedcf2498a78d1c8'
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
