require 'package'

class Xorg_nouveau_driver < Package
  description 'The Xorg Nouveau Driver package contains the X.Org Video Driver for NVidia Cards including RIVA TNT, RIVA TNT2, GeForce 256, QUADRO, GeForce2, QUADRO2, GeForce3, QUADRO DDC, nForce, nForce2, GeForce4, QUADRO4, GeForce FX, QUADRO FX, GeForce 6XXX and GeForce 7xxx chipsets.'
  homepage 'https://01.org/linuxgraphics/'
  version '1.0.15'
  compatibility 'all'
  source_url 'https://www.x.org/pub/individual/driver/xf86-video-nouveau-1.0.15.tar.bz2'
  source_sha256 'aede10fd395610a328697adca3434fb14e9afbd79911d6c8545cfa2c0e541d4c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_nouveau_driver-1.0.15-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_nouveau_driver-1.0.15-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_nouveau_driver-1.0.15-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_nouveau_driver-1.0.15-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '117d2cc14d320b1cdbe5e3f792022b796779d289553a8213607b132ee442090e',
     armv7l: '117d2cc14d320b1cdbe5e3f792022b796779d289553a8213607b132ee442090e',
       i686: 'fcd85ec40d2cb137fe5aae2ffd46a71b25e391b245da1405a1369c25f59af522',
     x86_64: '2f9589c902856d1b103ba62945fbad7b4a35ba8e9725d8f135d7d9b6ed7b0afb',
  })

  depends_on 'xorg_server' => :build
  
  # The new “Maxwell” and “Pascal” GPUs require Glamor to be built with the Xorg server.
  
  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--enable-shared',
           '--disable-static'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install-strip'
  end
end
