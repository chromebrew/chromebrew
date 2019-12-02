require 'package'

class Jdk8 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html'
  version '8u231'
  source_url 'http://hg.openjdk.java.net/jdk8/jdk8/archive/2a8f4c022aa0.tar.gz'
  source_sha256 'e632ae353ccfb90957cbb6a5818ee063710a41e7b97b490ee58ca5f627d863f1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u231-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u231-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u231-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u231-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b1545e8466aa05973583073f188568de7a4a616d274fb182b9a7efdf93fd73c9',
     armv7l: 'b1545e8466aa05973583073f188568de7a4a616d274fb182b9a7efdf93fd73c9',
       i686: '726d24cd9b6ec72fbec739e3474a7fab8f9b339e561b2969db285ae2abc89cf4',
     x86_64: '700c529caabc581218321af52bad08e40d2c7266437491fcb6519937b5afa65d',
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
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("#{HOME}/Downloads/jdk-#{version}-linux-arm32-vfp-hflt.tar.gz") ) == '8e864e5a7538a1d3f8b1e7077a9c5d3501ba9866c2f14c2b8204582f9fc76d9d'
      system "tar xvf #{HOME}/Downloads/jdk-#{version}-linux-arm32-vfp-hflt.tar.gz"
    when 'i686'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("#{HOME}/Downloads/jdk-#{version}-linux-i586.tar.gz") ) == '875207cd152b6c445234b20c2b5824b6a736b659eb8aab83f2a107a179d198a5'
      system "tar xvf #{HOME}/Downloads/jdk-#{version}-linux-i586.tar.gz"
    when 'x86_64'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("#{HOME}/Downloads/jdk-#{version}-linux-x64.tar.gz") ) == 'a011584a2c9378bf70c6903ef5fbf101b30b08937441dc2ec67932fb3620b2cf'
      system "tar xvf #{HOME}/Downloads/jdk-#{version}-linux-x64.tar.gz"
    end
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/jdk8"
    FileUtils.cd 'jdk1.8.0_231' do
      FileUtils.rm_f 'src.zip'
      FileUtils.cp_r Dir.glob('*'), "#{CREW_DEST_PREFIX}/share/jdk8/"
    end
    FileUtils.cd "#{CREW_DEST_PREFIX}/share/jdk8/bin" do
      system "find -type f -exec ln -s #{CREW_PREFIX}/share/jdk8/bin/{} #{CREW_DEST_PREFIX}/bin/{} \\;"
    end
    FileUtils.mv "#{CREW_DEST_PREFIX}/share/jdk8/man/", "#{CREW_DEST_PREFIX}/share/"
  end
end
