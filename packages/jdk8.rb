require 'package'

class Jdk8 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html'
  version '8u152'
  source_url 'http://hg.openjdk.java.net/jdk8/jdk8/archive/2a8f4c022aa0.tar.gz'
  source_sha256 'e632ae353ccfb90957cbb6a5818ee063710a41e7b97b490ee58ca5f627d863f1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u152-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u152-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u152-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u152-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '06220e44db6352f848eba5d3fe76b9d337016ebeb789092393232608a0bcce80',
     armv7l: '06220e44db6352f848eba5d3fe76b9d337016ebeb789092393232608a0bcce80',
       i686: '3573261088030e7e8fd77a243f57fa3f18a9b9d50420bb5b9cf272b5c11576cd',
     x86_64: '4b77cc68b00a1753815984561c142b0edf971e2121bcbfbcad08b7c2a497fd49',
  })

  def self.install
    case ARCH
    when 'aarch64', 'armv7l'
      system 'wget -c --header "Cookie: oraclelicense=accept-securebackup-cookie" --no-check-certificate https://download.oracle.com/otn-pub/java/jdk/8u152-b16/aa0333dd3019491ca4f6ddbe78cdb6d0/jdk-8u152-linux-arm32-vfp-hflt.tar.gz'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('jdk-8u152-linux-arm32-vfp-hflt.tar.gz') ) == '35ab532355c72310c4c7add2b7c7f9d1eb0e045cf59d3fd69ee08fa6a9e610f0'
      system 'tar xvf jdk-8u152-linux-arm32-vfp-hflt.tar.gz'
    when 'i686'
      system 'wget -c --header "Cookie: oraclelicense=accept-securebackup-cookie" --no-check-certificate https://download.oracle.com/otn-pub/java/jdk/8u152-b16/aa0333dd3019491ca4f6ddbe78cdb6d0/jdk-8u152-linux-i586.tar.gz'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('jdk-8u152-linux-i586.tar.gz') ) == 'fc60b121d4b194fa70084fd0ca0d69e8b78e5db01a071efe200e90eed83c4c3e'
      system 'tar xvf jdk-8u152-linux-i586.tar.gz'
    when 'x86_64'
      system 'wget -c --header "Cookie: oraclelicense=accept-securebackup-cookie" --no-check-certificate https://download.oracle.com/otn-pub/java/jdk/8u152-b16/aa0333dd3019491ca4f6ddbe78cdb6d0/jdk-8u152-linux-x64.tar.gz'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('jdk-8u152-linux-x64.tar.gz') ) == '218b3b340c3f6d05d940b817d0270dfe0cfd657a636bad074dcabe0c111961bf'
      system 'tar xvf jdk-8u152-linux-x64.tar.gz'
    end
    system "mkdir -p #{CREW_DEST_PREFIX}/share/jdk8"
    FileUtils.cd('jdk1.8.0_152') do
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
