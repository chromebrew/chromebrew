require 'package'

class Openjdk17 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'https://openjdk.org/'
  version '17.0.20.1'
  license 'GPL-2'
  compatibility 'all'
  # Visit https://www.azul.com/downloads/?version=java-17-lts&package=jdk#zulu to download the binaries.
  source_url({
    aarch64: 'https://cdn.azul.com/zulu/bin/zulu17.68.203-ca-jdk17.0.20.1-c2-linux_aarch32hf.tar.gz',
     armv7l: 'https://cdn.azul.com/zulu/bin/zulu17.68.203-ca-jdk17.0.20.1-c2-linux_aarch32hf.tar.gz',
       i686: 'https://cdn.azul.com/zulu/bin/zulu17.68.203-ca-jdk17.0.20.1-linux_i686.tar.gz',
     x86_64: 'https://cdn.azul.com/zulu/bin/zulu17.68.203-ca-jdk17.0.20.1-linux_x64.tar.gz'
  })
  source_sha256({
    aarch64: 'ba5ab210848b0eef35ae616aa1709776222b53612ca693e162b0833b0103afd8',
     armv7l: 'ba5ab210848b0eef35ae616aa1709776222b53612ca693e162b0833b0103afd8',
       i686: '827e3c6cf115189cc2aa440f7805ecea24bbc70e41d45010b93f27555f235c36',
     x86_64: '4ef843383724c7cee278b90aabe41c9ae172a3b2584ab0e086857bb536ef060f'
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
      unless jdkname == 'openjdk' && majver == '17'
        puts "Package #{jdkname}#{majver} already installed.".lightgreen
        abort "Enter `crew remove #{jdkname}#{majver} && crew install openjdk17` to install this version."
      end
    end
  end

  def self.install
    FileUtils.mkdir_p CREW_DEST_MAN_PREFIX
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/openjdk17"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/openjdk17/"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    Dir["#{CREW_DEST_PREFIX}/share/openjdk17/bin/*"].each do |binfile|
      @basename = File.basename(binfile)
      FileUtils.ln_s "#{CREW_PREFIX}/share/openjdk17/bin/#{@basename}", "#{CREW_DEST_PREFIX}/bin/#{@basename}"
    end
    FileUtils.mv Dir["#{CREW_DEST_PREFIX}/share/openjdk17/man/*"], CREW_DEST_MAN_PREFIX
    # Add environment variable.
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    javaenv = <<~EOF
      # Java configuration
      JAVA_HOME=#{CREW_PREFIX}
    EOF
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/10-openjdk17", javaenv)
  end
end
