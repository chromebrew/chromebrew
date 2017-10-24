require 'package'

class Jdk8 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html'
  version '8u152'
  source_url 'http://hg.openjdk.java.net/jdk8/jdk8/archive/2a8f4c022aa0.tar.gz'
  source_sha256 'e632ae353ccfb90957cbb6a5818ee063710a41e7b97b490ee58ca5f627d863f1'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.install
    case ARCH
    when 'aarch64'
      system 'wget -c --header "Cookie: oraclelicense=accept-securebackup-cookie" --no-check-certificate http://download.oracle.com/otn-pub/java/jdk/8u152-b16/aa0333dd3019491ca4f6ddbe78cdb6d0/jdk-8u152-linux-arm64-vfp-hflt.tar.gz'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('jdk-8u152-linux-arm64-vfp-hflt.tar.gz') ) == '732609dd090a7d20e09b48b90f8f447497879bb6da1b786a9dd1ea6e91ea178f'
      system 'tar xvf jdk-8u152-linux-arm64-vfp-hflt.tar.gz'
    when 'armv7l'
      system 'wget -c --header "Cookie: oraclelicense=accept-securebackup-cookie" --no-check-certificate https://download.oracle.com/otn-pub/java/jdk/8u152-b16/aa0333dd3019491ca4f6ddbe78cdb6d0/jdk-8u152-linux-arm32-vfp-hflt.tar.gz'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('jdk-8u152-linux-arm32-vfp-hflt.tar.gz') ) == '35ab532355c72310c4c7add2b7c7f9d1eb0e045cf59d3fd69ee08fa6a9e610f0'
      system 'tar xvf jdk-8u152-linux-arm32-vfp-hflt.tar.gz'
    when 'i686'
      system 'wget -c --header "Cookie: oraclelicense=accept-securebackup-cookie" --no-check-certificate http://download.oracle.com/otn-pub/java/jdk/8u152-b16/aa0333dd3019491ca4f6ddbe78cdb6d0/jdk-8u152-linux-i586.tar.gz'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('jdk-8u152-linux-i586.tar.gz') ) == 'fc60b121d4b194fa70084fd0ca0d69e8b78e5db01a071efe200e90eed83c4c3e'
      system 'tar xvf jdk-8u152-linux-i586.tar.gz'
    when 'x86_64'
      system 'wget -c --header "Cookie: oraclelicense=accept-securebackup-cookie" --no-check-certificate http://download.oracle.com/otn-pub/java/jdk/8u152-b16/aa0333dd3019491ca4f6ddbe78cdb6d0/jdk-8u152-linux-x64.tar.gz'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('jdk-8u152-linux-x64.tar.gz') ) == '218b3b340c3f6d05d940b817d0270dfe0cfd657a636bad074dcabe0c111961bf'
      system 'tar xvf jdk-8u152-linux-x64.tar.gz'
    end
    system "mkdir -p #{CREW_DEST_DIR}#{CREW_LIB_PREFIX}/jdk8"
    FileUtils.cd('jdk1.8.0_152') do
      system "rm -f src.zip"
      system "cp -r * #{CREW_DEST_DIR}#{CREW_LIB_PREFIX}/jdk8"
    end
    system "mkdir -p #{CREW_DEST_DIR}#{CREW_PREFIX}/bin"
    FileUtils.cd("#{CREW_DEST_DIR}#{CREW_PREFIX}/bin") do
      system "ln -s ../../../#{CREW_LIB_PREFIX}/jdk8/bin/* ."
    end
  end
end
