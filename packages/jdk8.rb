require 'package'

class Jdk8 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html'
  version '8u192'
  source_url 'http://hg.openjdk.java.net/jdk8/jdk8/archive/2a8f4c022aa0.tar.gz'
  source_sha256 'e632ae353ccfb90957cbb6a5818ee063710a41e7b97b490ee58ca5f627d863f1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u192-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u192-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u192-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u192-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8d7085d15860a07fa7177602fbd4222d8928fd107821f9402f7dede19afa5ced',
     armv7l: '8d7085d15860a07fa7177602fbd4222d8928fd107821f9402f7dede19afa5ced',
       i686: 'b77df06d79fa19348175424b6a9aee2ba3187921f66cdb797f9d7969adef24d5',
     x86_64: '63dda2c18271c4f1d1afd266b3817545f238dbd712b9559146516fdc08dbf8b3',
  })

  def self.install
    case ARCH
    when 'aarch64', 'armv7l'
      system 'wget -c --header "Cookie: oraclelicense=accept-securebackup-cookie" --no-check-certificate https://download.oracle.com/otn-pub/java/jdk/8u192-b12/750e1c8617c5452694857ad95c3ee230/jdk-8u192-linux-arm32-vfp-hflt.tar.gz'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('jdk-8u192-linux-arm32-vfp-hflt.tar.gz') ) == 'e8de2beec5e15631e4d87351eeb660e186d283cf359a52cec5c9c677db70e43b'
      system 'tar xvf jdk-8u192-linux-arm32-vfp-hflt.tar.gz'
    when 'i686'
      system 'wget -c --header "Cookie: oraclelicense=accept-securebackup-cookie" --no-check-certificate https://download.oracle.com/otn-pub/java/jdk/8u192-b12/750e1c8617c5452694857ad95c3ee230/jdk-8u192-linux-i586.tar.gz'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('jdk-8u192-linux-i586.tar.gz') ) == '1be1d7669a36f96d90a0856ab1973dedc632bfdfdf27ccb1c2232608b73e26ce'
      system 'tar xvf jdk-8u192-linux-i586.tar.gz'
    when 'x86_64'
      system 'wget -c --header "Cookie: oraclelicense=accept-securebackup-cookie" --no-check-certificate https://download.oracle.com/otn-pub/java/jdk/8u192-b12/750e1c8617c5452694857ad95c3ee230/jdk-8u192-linux-x64.tar.gz'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('jdk-8u192-linux-x64.tar.gz') ) == '6d34ae147fc5564c07b913b467de1411c795e290356538f22502f28b76a323c2'
      system 'tar xvf jdk-8u192-linux-x64.tar.gz'
    end
    system "mkdir -p #{CREW_DEST_PREFIX}/share/jdk8"
    FileUtils.cd('jdk1.8.0_192') do
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
