require 'package'

class Jdk8 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html'
  version '8u131'
  case ARCH
  when 'i686'
    source_url 'http://javadl.oracle.com/webapps/download/AutoDL?BundleId=220303_d54c1d3a095b4ff2b6607d096fa80163'
    source_sha1 '20d1a77783a01a592d9bcf3597256caee2ccfce0'
  when 'x86_64'
    source_url 'http://javadl.oracle.com/webapps/download/AutoDL?BundleId=220305_d54c1d3a095b4ff2b6607d096fa80163'
    source_sha1 '9303d3a8e8fc2d2eda014887fd92a6f5883f0170'
  when 'armv7l'
    source_url 'https://www.dropbox.com/s/vcejuitboafaxib/jdk8u22-armv7l.tar.gz'
    source_sha1 '913adb900bf0d9d42452a4591c1a9093076ed4b6'
  when 'aarch64'
    source_url 'https://www.dropbox.com/s/vcejuitboafaxib/jdk8u22-armv7l.tar.gz'
    source_sha1 '913adb900bf0d9d42452a4591c1a9093076ed4b6'
  else
    abort 'Unable to install jdk8.  Architecture not supported.'.lightred
  end
  def self.install
    system "mkdir -p #{CREW_DEST_DIR}/usr/local"
    system "cp -r bin/ #{CREW_DEST_DIR}/usr/local"
    system "cp -r lib/ #{CREW_DEST_DIR}/usr/local"
    system "cp -r man/ #{CREW_DEST_DIR}/usr/local"
  end
end
