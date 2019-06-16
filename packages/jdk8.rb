require 'package'

class Jdk8 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html'
  version '8u212'
  source_url 'http://hg.openjdk.java.net/jdk8/jdk8/archive/2a8f4c022aa0.tar.gz'
  source_sha256 'e632ae353ccfb90957cbb6a5818ee063710a41e7b97b490ee58ca5f627d863f1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u212-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u212-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u212-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u212-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'cde5bcf6c286691b5bf1fbf49409c66638442daac2cf46182cd892b8d8c4e967',
     armv7l: 'cde5bcf6c286691b5bf1fbf49409c66638442daac2cf46182cd892b8d8c4e967',
       i686: '4ba92cfa2d577612ba657599ed0b9bb5ee880c542693815d576ebc7d4ac63881',
     x86_64: 'e54a40e0a2cfe54cd5a9bbfe9dd8792f2aa1c33c62098876215e78ebe8b85eb7',
  })

  def self.install
    jdk=false
    case ARCH
    when 'aarch64', 'armv7l'
      jdk=true if File.exists? "#{HOME}/Downloads/jdk-8u212-linux-arm32-vfp-hflt.tar.gz"
    when 'i686'
      jdk=true if File.exists? "#{HOME}/Downloads/jdk-8u212-linux-i586.tar.gz"
    when 'x86_64'
      jdk=true if File.exists? "#{HOME}/Downloads/jdk-8u212-linux-x64.tar.gz"
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
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("#{HOME}/Downloads/jdk-8u212-linux-arm32-vfp-hflt.tar.gz") ) == 'dd6a8666dd340ae240c6431235d32e2ef218cb3b39aa1c63ada8373ca91a6374'
      system "tar xvf #{HOME}/Downloads/jdk-8u212-linux-arm32-vfp-hflt.tar.gz"
    when 'i686'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("#{HOME}/Downloads/jdk-8u212-linux-i586.tar.gz") ) == 'c1ca08b1032b1c6e4fe4e2516ce00984bf3ca987897ee2c2382b8eb8004eb20d'
      system "tar xvf #{HOME}/Downloads/jdk-8u212-linux-i586.tar.gz"
    when 'x86_64'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("#{HOME}/Downloads/jdk-8u212-linux-x64.tar.gz") ) == '3160c50aa8d8e081c8c7fe0f859ea452922eca5d2ae8f8ef22011ae87e6fedfb'
      system "tar xvf #{HOME}/Downloads/jdk-8u212-linux-x64.tar.gz"
    end
    system "mkdir -p #{CREW_DEST_PREFIX}/share/jdk8"
    FileUtils.cd('jdk1.8.0_212') do
      system "rm -f src.zip"
      system "cp -r * #{CREW_DEST_PREFIX}/share/jdk8"
    end
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    FileUtils.cd("#{CREW_DEST_PREFIX}/bin") do
      system "ln -s ../../../#{CREW_PREFIX}/share/jdk8/bin/* ."
    end
    FileUtils.cd("#{CREW_DEST_PREFIX}/share") do
      system "cp -r jdk8/man/ ."
      system "rm -rf jdk8/man/"
    end
  end
end
