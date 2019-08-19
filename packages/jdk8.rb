require 'package'

class Jdk8 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html'
  version '8u221'
  source_url 'http://hg.openjdk.java.net/jdk8/jdk8/archive/2a8f4c022aa0.tar.gz'
  source_sha256 'e632ae353ccfb90957cbb6a5818ee063710a41e7b97b490ee58ca5f627d863f1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u221-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u221-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u221-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u221-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '26ca71ccab77819651452a961b382e2151b61cf9d37a19dcf3fe82a90af2edd4',
     armv7l: '26ca71ccab77819651452a961b382e2151b61cf9d37a19dcf3fe82a90af2edd4',
       i686: '235378b13af8a3b12df65c742b667e253cfdff33bc9c43e524894c858a0b3d0b',
     x86_64: '57f53605284c2a55195051cfc315f039f31138ef2e094a71e44ce5b1bf19b93a',
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
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("#{HOME}/Downloads/jdk-#{version}-linux-arm32-vfp-hflt.tar.gz") ) == '848c315d316a55b5cb9a77a2e1fc055565ad167133880f78f4d7cd89f8ff1241'
      system "tar xvf #{HOME}/Downloads/jdk-#{version}-linux-arm32-vfp-hflt.tar.gz"
    when 'i686'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("#{HOME}/Downloads/jdk-#{version}-linux-i586.tar.gz") ) == '3237b483d36dfd3c8eccc9b56d84771efe2dd6803b97723b0826a87754134533'
      system "tar xvf #{HOME}/Downloads/jdk-#{version}-linux-i586.tar.gz"
    when 'x86_64'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("#{HOME}/Downloads/jdk-#{version}-linux-x64.tar.gz") ) == 'bac52b7f120a03c4c0815ca8fc77c02a8f3db2ded121ffad7449525f377e2479'
      system "tar xvf #{HOME}/Downloads/jdk-#{version}-linux-x64.tar.gz"
    end
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/jdk8"
    FileUtils.cd 'jdk1.8.0_221' do
      FileUtils.rm_f 'src.zip'
      FileUtils.cp_r Dir.glob('*'), "#{CREW_DEST_PREFIX}/share/jdk8/"
    end
    FileUtils.cd "#{CREW_DEST_PREFIX}/share/jdk8/bin" do
      system "find -type f -exec ln -s #{CREW_PREFIX}/share/jdk8/bin/{} #{CREW_DEST_PREFIX}/bin/{} \\;"
    end
    FileUtils.mv "#{CREW_DEST_PREFIX}/share/jdk8/man/", "#{CREW_DEST_PREFIX}/share/"
  end
end
