require 'package'

class Imagemagick < Package
  description 'Use ImageMagick to create, edit, compose, or convert bitmap images.'
  homepage 'http://www.imagemagick.org/script/index.php'
  version '7.0.7-18'
  source_url 'https://www.imagemagick.org/download/releases/ImageMagick-7.0.7-18.tar.xz'
  source_sha256 'd4987d7dc394c302916c1f1471e58932cda99706d7595d3a2467e501d971e136'

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
