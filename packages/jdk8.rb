require 'package'

class Jdk8 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html'
  version '8u131'
  binary_url ({
    i686: "http://javadl.oracle.com/webapps/download/AutoDL?BundleId=220303_d54c1d3a095b4ff2b6607d096fa80163",
    x86_64: "http://javadl.oracle.com/webapps/download/AutoDL?BundleId=220305_d54c1d3a095b4ff2b6607d096fa80163",
    armv7l: "https://www.dropbox.com/s/vcejuitboafaxib/jdk8u22-armv7l.tar.gz",
    aarch64: "https://www.dropbox.com/s/vcejuitboafaxib/jdk8u22-armv7l.tar.gz"
  })
  binary_sha1 ({
    i686:    '20d1a77783a01a592d9bcf3597256caee2ccfce0',
    x86_64:  '9303d3a8e8fc2d2eda014887fd92a6f5883f0170',
    aarch64: '913adb900bf0d9d42452a4591c1a9093076ed4b6',
    armv7l:  '913adb900bf0d9d42452a4591c1a9093076ed4b6'
  })
end
