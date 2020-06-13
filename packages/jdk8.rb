require 'package'

class Jdk8 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html'
  version '8u251'
  compatibility 'all'
  source_url 'https://hg.openjdk.java.net/jdk8/jdk8/archive/2a8f4c022aa0.tar.gz'
  source_sha256 'e632ae353ccfb90957cbb6a5818ee063710a41e7b97b490ee58ca5f627d863f1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u251-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u251-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u251-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u251-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '48a902d3754e13d38b0dc91e1ecb199569bf3f14bba2d6abf47263b16626d1f6',
     armv7l: '48a902d3754e13d38b0dc91e1ecb199569bf3f14bba2d6abf47263b16626d1f6',
       i686: '0402ad1e6e49a27ad1e0a0247bb5f52597f942131f05e05534037ec21181b66e',
     x86_64: 'cdf85676c12bf441bfb68ebdec8fc608ce6cb4420788b482ebc9c4a4260f4abd',
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
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("#{HOME}/Downloads/jdk-#{version}-linux-arm32-vfp-hflt.tar.gz") ) == 'f1b0c979e1b61ec52ebd5e1d0b754d7681d8623b09ac90c69718a553ef9b0cd1'
      system "tar xvf #{HOME}/Downloads/jdk-#{version}-linux-arm32-vfp-hflt.tar.gz"
    when 'i686'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("#{HOME}/Downloads/jdk-#{version}-linux-i586.tar.gz") ) == '0c6d25c09459e435570204f1a22a1cb765ce5d62c5bced92c9a9546b7be337f2'
      system "tar xvf #{HOME}/Downloads/jdk-#{version}-linux-i586.tar.gz"
    when 'x86_64'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("#{HOME}/Downloads/jdk-#{version}-linux-x64.tar.gz") ) == '777a8d689e863275a647ae52cb30fd90022a3af268f34fc5b9867ce32f1b374e'
      system "tar xvf #{HOME}/Downloads/jdk-#{version}-linux-x64.tar.gz"
    end
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/jdk8"
    FileUtils.cd 'jdk1.8.0_251' do
      FileUtils.rm_f 'src.zip'
      FileUtils.cp_r Dir.glob('*'), "#{CREW_DEST_PREFIX}/share/jdk8/"
    end
    FileUtils.cd "#{CREW_DEST_PREFIX}/share/jdk8/bin" do
      system "find -type f -exec ln -s #{CREW_PREFIX}/share/jdk8/bin/{} #{CREW_DEST_PREFIX}/bin/{} \\;"
    end
    FileUtils.mv "#{CREW_DEST_PREFIX}/share/jdk8/man/", "#{CREW_DEST_PREFIX}/share/"
  end
end
