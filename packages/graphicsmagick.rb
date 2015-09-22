require 'package'

class Graphicsmagick < Package
  version '1.3.21'
  source_url 'ftp://ftp.graphicsmagick.org/pub/GraphicsMagick/1.3/GraphicsMagick-1.3.21.tar.gz'
  source_sha1 '08dd77facf7d59f5e4d5eac04a4ab221e3bd9196'

  depends_on 'buildessential'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
