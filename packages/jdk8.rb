require 'package'

class Jdk8 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html'
  version '8u241'
  compatibility 'all'
  source_url 'http://hg.openjdk.java.net/jdk8/jdk8/archive/2a8f4c022aa0.tar.gz'
  source_sha256 'e632ae353ccfb90957cbb6a5818ee063710a41e7b97b490ee58ca5f627d863f1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u241-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u241-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u241-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u241-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5bfd4dca164d614b07b68de4872fe4a5083d1a1749ad67bacc4489115cb7111f',
     armv7l: '5bfd4dca164d614b07b68de4872fe4a5083d1a1749ad67bacc4489115cb7111f',
       i686: '389af1ea1cbe6a62e379e3d333b8deb36b10edf81663f60d75e39407b769481e',
     x86_64: '04accb5c208b239c27bad854e2f5571777cf4adb25a5c3f3e6c4a858d5c2833f',
  })

  def self.install
    jdk=false
    case ARCH
    when 'aarch64', 'armv7l'
      jdk=true if File.exists? "#{HOME}/Downloads/jdk-#{version}-linux-arm32-vfp-hflt.tar.gz"
    when 'i686'
      jdk=true if File.exists? "#{HOME}/Downloads/jdk-#{version}-linux-i586.tar.gz"
    when 'x86_64'
      jdk=true if File.exists? "#{HOME}/Downloads/jdk-#{version}-linux-x64.tar.gz"
    end
    unless jdk then
      puts
      puts "Oracle now requires an account to download the JDK.".orange
      puts
      puts "You must login at https://login.oracle.com/oaam_server/login.do and then visit:".orange
      puts "http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html".orange
      puts
      puts "Download the JDK for your architecture to #{HOME}/Downloads to continue.".orange
      puts
      abort
    end
    case ARCH
    when 'aarch64', 'armv7l'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("#{HOME}/Downloads/jdk-#{version}-linux-arm32-vfp-hflt.tar.gz") ) == '4470cc89f78d31b173fc1cc1b2a39e15c9a31ebfae7c003777df928643f45fde'
      system "tar xvf #{HOME}/Downloads/jdk-#{version}-linux-arm32-vfp-hflt.tar.gz"
    when 'i686'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("#{HOME}/Downloads/jdk-#{version}-linux-i586.tar.gz") ) == 'e4f901999e5930c1e7606d08a1ebde0ed31d841dae3106a0def823bf5ce431da'
      system "tar xvf #{HOME}/Downloads/jdk-#{version}-linux-i586.tar.gz"
    when 'x86_64'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("#{HOME}/Downloads/jdk-#{version}-linux-x64.tar.gz") ) == '419d32677855f676076a25aed58e79432969142bbd778ff8eb57cb618c69e8cb'
      system "tar xvf #{HOME}/Downloads/jdk-#{version}-linux-x64.tar.gz"
    end
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/jdk8"
    FileUtils.cd 'jdk1.8.0_241' do
      FileUtils.rm_f 'src.zip'
      FileUtils.cp_r Dir.glob('*'), "#{CREW_DEST_PREFIX}/share/jdk8/"
    end
    FileUtils.cd "#{CREW_DEST_PREFIX}/share/jdk8/bin" do
      system "find -type f -exec ln -s #{CREW_PREFIX}/share/jdk8/bin/{} #{CREW_DEST_PREFIX}/bin/{} \\;"
    end
    FileUtils.mv "#{CREW_DEST_PREFIX}/share/jdk8/man/", "#{CREW_DEST_PREFIX}/share/"
  end
end
