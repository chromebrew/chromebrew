require 'package'

class Muparser < Package
  description 'muParser is an extensible high performance math expression parser library written in C++.'
  homepage 'http://beltoforion.de/article.php?a=muparser'
  version '2.6.1'
  compatibility 'all'
  source_url 'https://github.com/beltoforion/muparser/archive/v2.2.6.1.tar.gz'
  source_sha256 'd2562853d972b6ddb07af47ce8a1cdeeb8bb3fa9e8da308746de391db67897b3'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/muparser-2.6.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/muparser-2.6.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/muparser-2.6.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/muparser-2.6.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4fce29777174db06a8b8ced631ed78b16f2ccbee130cc5a72ff80035ee9b788e',
     armv7l: '4fce29777174db06a8b8ced631ed78b16f2ccbee130cc5a72ff80035ee9b788e',
       i686: '7491c925d7a81eb17bbb1746aa3b6bfee18c6e62e4a43a5bbde4e7b620fee76c',
     x86_64: 'f00187a350bb837e95c946ed8a85fcfa47ee62e34891155dd4a9f255aa529b39',
  })

  def self.build
    system "./configure \
           --prefix=#{CREW_PREFIX} \
           --libdir=#{CREW_LIB_PREFIX} \
           --enable-shared=yes \
           --enable-samples=no \
           --enable-debug=no"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
