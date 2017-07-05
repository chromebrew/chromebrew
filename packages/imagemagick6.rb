require 'package'

class Imagemagick6 < Package
  description 'Use ImageMagick to create, edit, compose, or convert bitmap images.'
  homepage 'http://www.imagemagick.org/script/index.php'
  version '6.9.8.10'
  source_url 'https://dl.bintray.com/homebrew/mirror/imagemagick%406-6.9.8-10.tar.xz'
  source_sha256 '8fc268f6e1bc514b41620e0f3f6c5dd33bfc5169db679e9a5c0455c6edd11810'

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
