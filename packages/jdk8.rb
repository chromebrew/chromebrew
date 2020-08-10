require 'package'

class Jdk8 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'https://www.oracle.com/java/technologies/javase/javase-jdk8-downloads.html'
  version '8u261'
  compatibility 'all'
  source_url 'https://hg.openjdk.java.net/jdk8/jdk8/archive/2a8f4c022aa0.tar.gz'
  source_sha256 'e632ae353ccfb90957cbb6a5818ee063710a41e7b97b490ee58ca5f627d863f1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u261-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u261-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u261-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u261-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'db6d59a9b314d88444d15a9bc17ae8878903a828497d3e7a13e12ad84185cab3',
     armv7l: 'db6d59a9b314d88444d15a9bc17ae8878903a828497d3e7a13e12ad84185cab3',
       i686: '471d97fe4a511bd953b7efede056f283b4d1ddc195f92024998854f4caab1bd5',
     x86_64: 'ddd85fbc3e20f6a1e9418b06e947f876dc9a8173125b5b2e2e8c9d4017a001e0',
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
      puts "https://www.oracle.com/java/technologies/javase/javase-jdk8-downloads.html".orange
      puts
      puts "Download the JDK for your architecture to #{HOME}/Downloads to continue.".orange
      puts
      abort
    end
    case ARCH
    when 'aarch64', 'armv7l'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("#{HOME}/Downloads/jdk-#{version}-linux-arm32-vfp-hflt.tar.gz") ) == 'e9364badce5ce65e5bbc3f176e64c678a68650bdb03b0be702493ee7ff81b18d'
      system "tar xvf #{HOME}/Downloads/jdk-#{version}-linux-arm32-vfp-hflt.tar.gz"
    when 'i686'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("#{HOME}/Downloads/jdk-#{version}-linux-i586.tar.gz") ) == 'f54a778bde277a5d1c2d9021949b05fcd7add69893672449437594581a1481ae'
      system "tar xvf #{HOME}/Downloads/jdk-#{version}-linux-i586.tar.gz"
    when 'x86_64'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("#{HOME}/Downloads/jdk-#{version}-linux-x64.tar.gz") ) == '5a04e01a091f6b1ed9c0b801be4fd10689af07eeb9e27f012c9aa3af9948ea34'
      system "tar xvf #{HOME}/Downloads/jdk-#{version}-linux-x64.tar.gz"
    end
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/jdk8"
    FileUtils.cd 'jdk1.8.0_261' do
      FileUtils.rm_f 'src.zip'
      FileUtils.cp_r Dir.glob('*'), "#{CREW_DEST_PREFIX}/share/jdk8/"
    end
    FileUtils.cd "#{CREW_DEST_PREFIX}/share/jdk8/bin" do
      system "find -type f -exec ln -s #{CREW_PREFIX}/share/jdk8/bin/{} #{CREW_DEST_PREFIX}/bin/{} \\;"
    end
    FileUtils.mv "#{CREW_DEST_PREFIX}/share/jdk8/man/", "#{CREW_DEST_PREFIX}/share/"
  end
end
