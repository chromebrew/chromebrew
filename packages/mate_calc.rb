require 'package'

class Mate_calc < Package
  description 'Calculator for MATE.'
  homepage 'https://mate-desktop.org'
  version '1.21'
  compatibility 'all'
  source_url 'https://pub.mate-desktop.org/releases/1.21/mate-calc-1.21.0.tar.xz'
  source_sha256 'c6b2c4d832f67d5f3d1293cb143e428365077e3cdfe4fc4bb80b3fce5362b51e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mate_calc-1.21-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mate_calc-1.21-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mate_calc-1.21-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mate_calc-1.21-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '311ade356f6259ca68ebf2318b7dfec9053e51899c3bb033b91e091479d587f6',
     armv7l: '311ade356f6259ca68ebf2318b7dfec9053e51899c3bb033b91e091479d587f6',
       i686: '1e3ce84febcc23812533a02f4d49b3ed4bb7b4a9a97f50cd220313ee9d701884',
     x86_64: 'c5848a45335a4bcbb9e4066c3e90875a82b3ebc1486fe1279ded5babbddd3148',
  })

  depends_on 'gtk3'
  depends_on 'mate_common'
  depends_on 'yelp_tools'

  def self.build
    system "sh autogen.sh"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" # the steps required to install the package
  end
  
end
