require 'package'

class Graphicsmagick < Package
  description 'GraphicsMagick is the swiss army knife of image processing.'
  homepage 'http://www.graphicsmagick.org/'
  version '1.3.27'
  source_url 'https://downloads.sourceforge.net/project/graphicsmagick/graphicsmagick/1.3.27/GraphicsMagick-1.3.27.tar.xz'
  source_sha256 'd03278d2790efc1dc72309f85a539810d2a81deb47932f7e6720d09ac72d0367'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
