require 'package'

class Jdk8 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html'
  version '8u162'
  source_url 'http://hg.openjdk.java.net/jdk8/jdk8/archive/2a8f4c022aa0.tar.gz'
  source_sha256 'e632ae353ccfb90957cbb6a5818ee063710a41e7b97b490ee58ca5f627d863f1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u162-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u162-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u162-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u162-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bcbf7202fb97074c4161455d6a921378b4ce43b3fd430546b92d83d60c65fcc2',
     armv7l: 'bcbf7202fb97074c4161455d6a921378b4ce43b3fd430546b92d83d60c65fcc2',
       i686: '81d015255c8f1bbe9c78b6b78cc75cfd81fd63777ad8e1b1f1151d7f37d4889b',
     x86_64: 'eebda392cdcdfee0cefac114edbfa4a39f8d76e83eb380e51e9bbc4a202206f1',
  })

  def self.install
    case ARCH
    when 'aarch64', 'armv7l'
      system 'wget -c --header "Cookie: oraclelicense=accept-securebackup-cookie" --no-check-certificate https://download.oracle.com/otn-pub/java/jdk/8u162-b12/0da788060d494f5095bf8624735fa2f1/jdk-8u162-linux-arm32-vfp-hflt.tar.gz'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('jdk-8u162-linux-arm32-vfp-hflt.tar.gz') ) == '57720cc98e0dd709e8439df73d70cd1252d76f059e3e08ce0b36e8776b7bfa77'
      system 'tar xvf jdk-8u162-linux-arm32-vfp-hflt.tar.gz'
    when 'i686'
      system 'wget -c --header "Cookie: oraclelicense=accept-securebackup-cookie" --no-check-certificate https://download.oracle.com/otn-pub/java/jdk/8u162-b12/0da788060d494f5095bf8624735fa2f1/jdk-8u162-linux-i586.tar.gz'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('jdk-8u162-linux-i586.tar.gz') ) == 'eecf88dbcf7c78d236251d44350126f1297a522f2eab974b4027ef20f7a6fb24'
      system 'tar xvf jdk-8u162-linux-i586.tar.gz'
    when 'x86_64'
      system 'wget -c --header "Cookie: oraclelicense=accept-securebackup-cookie" --no-check-certificate https://download.oracle.com/otn-pub/java/jdk/8u162-b12/0da788060d494f5095bf8624735fa2f1/jdk-8u162-linux-x64.tar.gz'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('jdk-8u162-linux-x64.tar.gz') ) == '68ec82d47fd9c2b8eb84225b6db398a72008285fafc98631b1ff8d2229680257'
      system 'tar xvf jdk-8u162-linux-x64.tar.gz'
    end
    system "mkdir -p #{CREW_DEST_PREFIX}/share/jdk8"
    FileUtils.cd('jdk1.8.0_162') do
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
