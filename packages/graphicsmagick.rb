require 'package'

class Graphicsmagick < Package
  description 'GraphicsMagick is the swiss army knife of image processing.'
  homepage 'http://www.graphicsmagick.org/'
  version '1.3.23'
  source_url 'http://downloads.sourceforge.net/project/graphicsmagick/graphicsmagick/1.3.23/GraphicsMagick-1.3.23.tar.gz'
  source_sha256 'cb320e009173c66927041a675755fad454b8aadf1da2c6fd1d65eac298c556db'

  depends_on 'buildessential'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
