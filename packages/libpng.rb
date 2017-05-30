require 'package'

class Libpng < Package
  description 'libpng is the official PNG reference library.'
  homepage 'http://libpng.org/pub/png/libpng.html'
  version '1.6.28'
  source_url 'http://prdownloads.sourceforge.net/libpng/libpng-1.6.28.tar.gz'
  source_sha1 '004556d65f21baed83755f8e094112711e39ebae'

  def self.build
      system "./configure CFLAGS=\" -fPIC\""
      system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
