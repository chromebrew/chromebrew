require 'package'

class Jdk8 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html'
  version '8u172'
  source_url 'http://hg.openjdk.java.net/jdk8/jdk8/archive/2a8f4c022aa0.tar.gz'
  source_sha256 'e632ae353ccfb90957cbb6a5818ee063710a41e7b97b490ee58ca5f627d863f1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u172-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u172-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u172-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/jdk8-8u172-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '90f418f144133a3776017729599465f9efa1b675ae402c20d22e9007bce901ad',
     armv7l: '90f418f144133a3776017729599465f9efa1b675ae402c20d22e9007bce901ad',
       i686: 'efe0479401b215616a682a1bcb487d0a9dd1646354bfa344c39f0510f14c3ff0',
     x86_64: '827c56c9b2b24cbac1000c13146f568eb6d6ffaa8fde2db702569eaff169e92e',
  })

  def self.install
    case ARCH
    when 'aarch64', 'armv7l'
      system 'wget -c --header "Cookie: oraclelicense=accept-securebackup-cookie" --no-check-certificate https://download.oracle.com/otn-pub/java/jdk/8u172-b11/a58eab1ec242421181065cdc37240b08/jdk-8u172-linux-arm32-vfp-hflt.tar.gz'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('jdk-8u172-linux-arm32-vfp-hflt.tar.gz') ) == '965e6cca2255a34e0e44ba8cf00c53472bc9837f080d58ad6e82309ac162e694'
      system 'tar xvf jdk-8u172-linux-arm32-vfp-hflt.tar.gz'
    when 'i686'
      system 'wget -c --header "Cookie: oraclelicense=accept-securebackup-cookie" --no-check-certificate https://download.oracle.com/otn-pub/java/jdk/8u172-b11/a58eab1ec242421181065cdc37240b08/jdk-8u172-linux-i586.tar.gz'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('jdk-8u172-linux-i586.tar.gz') ) == '0a4310d31246924d5c3cd161b9da7f446acef373e6484452c80de8d8519f5a33'
      system 'tar xvf jdk-8u172-linux-i586.tar.gz'
    when 'x86_64'
      system 'wget -c --header "Cookie: oraclelicense=accept-securebackup-cookie" --no-check-certificate https://download.oracle.com/otn-pub/java/jdk/8u172-b11/a58eab1ec242421181065cdc37240b08/jdk-8u172-linux-x64.tar.gz'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('jdk-8u172-linux-x64.tar.gz') ) == '28a00b9400b6913563553e09e8024c286b506d8523334c93ddec6c9ec7e9d346'
      system 'tar xvf jdk-8u172-linux-x64.tar.gz'
    end
    system "mkdir -p #{CREW_DEST_PREFIX}/share/jdk8"
    FileUtils.cd('jdk1.8.0_172') do
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
