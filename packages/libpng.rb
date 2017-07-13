require 'package'

class Libpng < Package
  description 'libpng is the official PNG reference library.'
  homepage 'http://libpng.org/pub/png/libpng.html'
  version '1.6.28'
  source_url 'http://prdownloads.sourceforge.net/libpng/libpng-1.6.28.tar.gz'
  source_sha256 'b6cec903e74e9fdd7b5bbcde0ab2415dd12f2f9e84d9e4d9ddd2ba26a41623b2'

  def self.build
      system "./configure CFLAGS=\" -fPIC\""
      system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
