require 'package'

class Imagemagick6 < Package
  description 'Use ImageMagick to create, edit, compose, or convert bitmap images.'
  homepage 'http://www.imagemagick.org/script/index.php'
  version '6.9.9.0'
  source_url 'https://dl.bintray.com/homebrew/mirror/imagemagick%406-6.9.9-0.tar.xz'
  source_sha256 '0a8a091dc4f57ec486e03285a1c30dc3f062d58133f848b6274dfc6ae5dbb60b'

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
