require 'package'

class Libpng < Package
  version '1.6.24'
  source_url 'http://downloads.sourceforge.net/project/libpng/libpng16/1.6.24/libpng-1.6.24.tar.xz'
  source_sha1 'b8fa86449bebd7b1cda71e0ed2cd417b6596ce78'

  def self.build
      system "./configure --libdir=/usr/local/lib#{SHORTARCH}/ CC=\"gcc -m#{SHORTARCH}\" CFLAGS=\" -fPIC\""
      system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
