require 'package'

class Imagemagick < Package
  description 'Use ImageMagick to create, edit, compose, or convert bitmap images.'
  homepage 'http://www.imagemagick.org/script/index.php'
  version '7.0.7-9'
  source_url 'https://www.imagemagick.org/download/releases/ImageMagick-7.0.7-11.tar.xz'
  source_sha256 '7993942d64c138f6c3e9d4bce6d8c13f747128bafe5c2295dcb45d91d1ff21e3'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "./configure CFLAGS=\" -fPIC\" --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} --without-python --disable-dependency-tracking"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
