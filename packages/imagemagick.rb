require 'package'

class Imagemagick < Package
  version '6.9.2-10-1'
  source_url 'http://www.imagemagick.org/download/releases/ImageMagick-6.9.2-10.tar.xz'
  source_sha1 'd0b3fdf8f25856bf0058716703f7bf989560d2ce'
  
  depends_on 'pkgconfig'

  def self.build
    system "./configure CFLAGS=\" -fPIC\" --without-python"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
