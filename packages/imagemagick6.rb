require 'package'

class Imagemagick6 < Package
  description 'Use ImageMagick to create, edit, compose, or convert bitmap images.'
  homepage 'http://www.imagemagick.org/script/index.php'
  version '6.9.9-5'
  source_url 'https://www.imagemagick.org/download/releases/ImageMagick-6.9.9-5.tar.xz'
  source_sha256 'aa6444ece8d29b87fb4f25e997cd0b4fb48774206cea9490c6028babdee7d056'

  depends_on 'pkgconfig'
  depends_on "libjpeg"
  depends_on "libpng"
  depends_on "libtiff"
  depends_on "freetype"
  depends_on "zlibpkg"

  def self.build
    system "./configure CFLAGS=\" -fPIC\" --without-python"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
