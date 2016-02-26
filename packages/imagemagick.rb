require 'package'

class Imagemagick < Package
  version '6.9.3-0'
  source_url 'http://www.imagemagick.org/download/releases/ImageMagick-6.9.3-0.tar.xz'
  source_sha1 '2ba0656eb03d72d8a44e741ead524e8c34097418c0bb5487a5c4f4fe5eca9656'

  def self.build
    system "./configure --libdir=/usr/local/lib#{SHORTARCH}/ CC=\"gcc -m#{SHORTARCH}\" CFLAGS=\" -fPIC\" --without-python"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
