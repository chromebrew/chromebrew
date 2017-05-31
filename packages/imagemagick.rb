require 'package'

class Imagemagick < Package
  description 'Use ImageMagick to create, edit, compose, or convert bitmap images.'
  homepage 'http://www.imagemagick.org/script/index.php'
  version '7.0.5-4'
  source_url 'https://www.imagemagick.org/download/ImageMagick-7.0.5-4.tar.xz'
  source_sha1 '118b2d1753cf5eb0761ea8dac068e24217b8e32b'
  
  depends_on 'pkgconfig'

  def self.build
    system "./configure CFLAGS=\" -fPIC\" --without-python"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
