require 'package'

class Jdk8 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html'
  version '8u111'
  binary_url ({
    i686: "http://javadl.oracle.com/webapps/download/AutoDL?BundleId=216422",
    x86_64: "http://javadl.oracle.com/webapps/download/AutoDL?BundleId=216424",
    armv7l: "https://www.dropbox.com/s/vcejuitboafaxib/jdk8u22-armv7l.tar.gz",
    aarch64: "https://www.dropbox.com/s/vcejuitboafaxib/jdk8u22-armv7l.tar.gz"
  })
  binary_sha1 ({
    i686:    '37556a34403cb6d76c6e51471627c9e07727ea2d',
    x86_64:  'd09fa2b77b6cf05ba835377a00ef495e6deebe1b',
    aarch64: '913adb900bf0d9d42452a4591c1a9093076ed4b6',
    armv7l:  '913adb900bf0d9d42452a4591c1a9093076ed4b6'
  })
end
