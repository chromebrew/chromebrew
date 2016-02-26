require 'package'

class Imagemagick < Package
  version '6.9.3-5'
  source_url 'http://www.imagemagick.org/download/releases/ImageMagick-6.9.3-5.tar.xz'
  source_sha1 'aa42c3a08eb807a4da9c117f8640f9239617ce76'

  def self.build
    system "./configure --libdir=/usr/local/lib#{SHORTARCH}/ CC=\"gcc -m#{SHORTARCH}\" CFLAGS=\" -fPIC\" --without-python"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
