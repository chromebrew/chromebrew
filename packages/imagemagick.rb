require 'package'

class Imagemagick < Package
  version '7.0.4-7'
  source_url 'http://www.imagemagick.org/download/releases/ImageMagick-7.0.4-7.tar.xz'
  source_sha1 'a0811b4ea76892a2ef2ac8a7e82b314c32f8ec42'
  
  depends_on 'pkgconfig'

  def self.build
    system "./configure CFLAGS=\" -fPIC\" --without-python"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
