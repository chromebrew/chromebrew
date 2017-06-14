require 'package'

class Jdk8 < Package
  description 'The JDK is a development environment for building applications, applets, and components using the Java programming language.'
  homepage 'http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html'
  version '8u112'
  binary_url ({
    i686: "https://www.dropbox.com/s/0c9yratmcf5fdpq/jdk8u112-i686.tar.gz",
    x86_64: "https://www.dropbox.com/s/efa747g7or3294u/jdk8u112-x86_64.tar.gz",
    armv7l: "https://www.dropbox.com/s/vcejuitboafaxib/jdk8u22-armv7l.tar.gz",
    aarch64: "https://www.dropbox.com/s/vcejuitboafaxib/jdk8u22-armv7l.tar.gz"
  })
  binary_sha1 ({
    aarch64: '913adb900bf0d9d42452a4591c1a9093076ed4b6',
    armv7l:  '913adb900bf0d9d42452a4591c1a9093076ed4b6',
    i686:    '65de377470bdd42e4f3e158b16917166ebe47a02',
    x86_64:  '9a009b3b33cbb82ec70e7b0061973b09308c7fed',
  })
end
