require 'package'

class Jdk15 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'https://www.oracle.com/java/technologies/javase-jdk15-downloads.html'
  version '15.0.1'
  compatibility 'x86_64'
  case ARCH
  when 'x86_64'
    source_url 'file:///dev/null'
    source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'
  end

  binary_url ({
    x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/jdk15-15.0.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    x86_64: '456f4cca19b0e5bbc89cba06b80527861647fd7f6e740b476cd2cd86cefaacdd',
  })

  case ARGV[0]
  when 'install', 'reinstall'
    abort "JDK8 installed.".lightgreen if Dir.exists? "#{CREW_PREFIX}/share/jdk8"
    abort "JDK11 installed.".lightgreen if Dir.exists? "#{CREW_PREFIX}/share/jdk11"
  end

  def self.install
    jdk_bin = "#{HOME}/Downloads/jdk-#{version}_linux-x64_bin.tar.gz"
    jdk_sha256 = '445a1c5c335b53b030f68aca58493ddedd49f4b53085618bc1ae7aba68156606'
    unless File.exists? jdk_bin then
      puts
      puts "Oracle now requires an account to download the JDK.".orange
      puts
      puts "You must login at https://login.oracle.com/mysso/signon.jsp and then visit:".orange
      puts "https://www.oracle.com/java/technologies/javase-jdk15-downloads.html".orange
      puts
      puts "Download the JDK for your architecture to #{HOME}/Downloads to continue.".orange
      puts
      abort
    end
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read(jdk_bin) ) == jdk_sha256
    system "tar xvf #{jdk_bin}"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/jdk15"
    FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/man1"
    FileUtils.cd "jdk-#{version}" do
      FileUtils.rm_f 'lib/src.zip'
      FileUtils.mv Dir.glob('*'), "#{CREW_DEST_PREFIX}/share/jdk15/"
    end
    FileUtils.cd "#{CREW_DEST_PREFIX}/share/jdk15/bin" do
      system "find -type f -exec ln -s #{CREW_PREFIX}/share/jdk15/bin/{} #{CREW_DEST_PREFIX}/bin/{} \\;"
    end
    system "compressdoc --gzip -9 #{CREW_DEST_PREFIX}/share/jdk15/man/man1"
    FileUtils.cd "#{CREW_DEST_PREFIX}/share/jdk15/man/man1" do
      system "find -type f -exec ln -s #{CREW_PREFIX}/share/jdk15/man/man1/{} #{CREW_DEST_MAN_PREFIX}/man1/{} \\;"
    end
  end
end
