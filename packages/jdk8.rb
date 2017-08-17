require 'package'

class Jdk8 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html'
  version '8u144'
  source_url 'http://hg.openjdk.java.net/jdk8/jdk8/archive/2a8f4c022aa0.tar.gz'
  source_sha256 'e632ae353ccfb90957cbb6a5818ee063710a41e7b97b490ee58ca5f627d863f1'

  def self.install
    case ARCH
    when 'aarch64'
      system 'wget -c --header "Cookie: oraclelicense=accept-securebackup-cookie" --no-check-certificate https://download.oracle.com/otn-pub/java/jdk/8u144-b01/090f390dda5b47b9b721c7dfaa008135/jdk-8u144-linux-arm32-vfp-hflt.tar.gz'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('jdk-8u144-linux-arm32-vfp-hflt.tar.gz') ) == 'cbbd390e19ab4c473e05f60602ce2804db25e4e35be5ab95f4f1a2aeb5b72383'
      system 'tar xvf jdk-8u144-linux-arm32-vfp-hflt.tar.gz'
    when 'armv7l'
      system 'wget -c --header "Cookie: oraclelicense=accept-securebackup-cookie" --no-check-certificate https://download.oracle.com/otn-pub/java/jdk/8u144-b01/090f390dda5b47b9b721c7dfaa008135/jdk-8u144-linux-arm32-vfp-hflt.tar.gz'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('jdk-8u144-linux-arm32-vfp-hflt.tar.gz') ) == 'cbbd390e19ab4c473e05f60602ce2804db25e4e35be5ab95f4f1a2aeb5b72383'
      system 'tar xvf jdk-8u144-linux-arm32-vfp-hflt.tar.gz'
    when 'i686'
      system 'wget -c --header "Cookie: oraclelicense=accept-securebackup-cookie" --no-check-certificate https://download.oracle.com/otn-pub/java/jdk/8u144-b01/090f390dda5b47b9b721c7dfaa008135/jdk-8u144-linux-i586.tar.gz'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('jdk-8u144-linux-i586.tar.gz') ) == '624c090647629394ef0ee08d9d8ac5d3d5a9a60fa245fefb2eb417c36c7cb7c4'
      system 'tar xvf jdk-8u144-linux-i586.tar.gz'
    when 'x86_64'
      system 'wget -c --header "Cookie: oraclelicense=accept-securebackup-cookie" --no-check-certificate https://download.oracle.com/otn-pub/java/jdk/8u144-b01/090f390dda5b47b9b721c7dfaa008135/jdk-8u144-linux-x64.tar.gz'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('jdk-8u144-linux-x64.tar.gz') ) == 'e8a341ce566f32c3d06f6d0f0eeea9a0f434f538d22af949ae58bc86f2eeaae4'
      system 'tar xvf jdk-8u144-linux-x64.tar.gz'
    end
    system "mkdir -p #{CREW_DEST_DIR}#{CREW_LIB_PREFIX}/jdk8"
    FileUtils.cd('jdk1.8.0_144') do
      system "rm -f src.zip"
      system "cp -r * #{CREW_DEST_DIR}#{CREW_LIB_PREFIX}/jdk8"
    end
    system "mkdir -p #{CREW_DEST_DIR}#{CREW_PREFIX}/bin"
    FileUtils.cd("#{CREW_DEST_DIR}#{CREW_PREFIX}/bin") do
      system "ln -s ../../../#{CREW_LIB_PREFIX}/jdk8/bin/* ."
    end
  end
end
