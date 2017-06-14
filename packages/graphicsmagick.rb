require 'package'

class Graphicsmagick < Package
  description 'GraphicsMagick is the swiss army knife of image processing.'
  homepage 'http://www.graphicsmagick.org/'
  version '1.3.23'
  source_url 'http://downloads.sourceforge.net/project/graphicsmagick/graphicsmagick/1.3.23/GraphicsMagick-1.3.23.tar.gz'
  source_sha1 'ad43788153e11e5123ac94b60a2c9acc74036d70'

  depends_on 'buildessential'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
