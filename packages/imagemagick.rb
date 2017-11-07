require 'package'

class Imagemagick < Package
  description 'Use ImageMagick to create, edit, compose, or convert bitmap images.'
  homepage 'http://www.imagemagick.org/script/index.php'
  version '7.0.7-9'
  source_url 'https://www.imagemagick.org/download/releases/ImageMagick-7.0.7-9.tar.xz'
  source_sha256 'dc0c7418e20d9f113b3c3ae6903ed89d00a95465bd3f5e15832f3b06593a085c'

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
