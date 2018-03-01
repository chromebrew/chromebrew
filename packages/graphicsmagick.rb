require 'package'

class Graphicsmagick < Package
  description 'GraphicsMagick is the swiss army knife of image processing.'
  homepage 'http://www.graphicsmagick.org/'
  version '1.3.27'
  source_url 'https://downloads.sourceforge.net/project/graphicsmagick/graphicsmagick/1.3.27/GraphicsMagick-1.3.27.tar.xz'
  source_sha256 'd03278d2790efc1dc72309f85a539810d2a81deb47932f7e6720d09ac72d0367'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/graphicsmagick-1.3.27-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/graphicsmagick-1.3.27-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/graphicsmagick-1.3.27-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/graphicsmagick-1.3.27-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '42f651c837a0ae63bf5822eaf5ad53321a09ef19040372aaae2ca01d00ae986f',
     armv7l: '42f651c837a0ae63bf5822eaf5ad53321a09ef19040372aaae2ca01d00ae986f',
       i686: '5813d51708e29fe5a9debc1682600f086e43c644b04e5bff238dc23cdd1ed895',
     x86_64: '03ad955a5521ba4c62eb6e0c0a6b8e8bd9b10123b77b10fb11d5b3bfe9812a36',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} --without-x"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
