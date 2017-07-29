require 'package'

class Imagemagick6 < Package
  description 'Use ImageMagick to create, edit, compose, or convert bitmap images.'
  homepage 'http://www.imagemagick.org/script/index.php'
  version '6.9.9-4'
  source_url 'https://www.imagemagick.org/download/releases/ImageMagick-6.9.9-4.tar.xz'
  source_sha256 'beb6545d8914005ed4e1cc6b718cab57b4f6d26d01361792e6ad75050a44f4c1'

  depends_on 'pkgconfig'
  depends_on "libjpeg"
  depends_on "libpng"
  depends_on "libtiff"
  depends_on "freetype"

  def self.build
    system "./configure CFLAGS=\" -fPIC\" --without-python"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
