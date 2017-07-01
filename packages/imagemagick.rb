require 'package'

class Imagemagick < Package
  description 'Use ImageMagick to create, edit, compose, or convert bitmap images.'
  homepage 'http://www.imagemagick.org/script/index.php'
  version '7.0.6-0'
  source_url 'https://www.imagemagick.org/download/ImageMagick-7.0.6-0.tar.xz'
  source_sha256 '31587e2aa4d46301461329fd88d4ed6fccb0bd4ae786d629a153df72dbac89ee'

  depends_on 'pkgconfig'

  def self.build
    system "./configure CFLAGS=\" -fPIC\" --without-python"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
