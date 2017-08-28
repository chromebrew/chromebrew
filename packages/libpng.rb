require 'package'

class Libpng < Package
  description 'libpng is the official PNG reference library.'
  homepage 'http://libpng.org/pub/png/libpng.html'
  version '1.6.32'
  source_url 'http://prdownloads.sourceforge.net/libpng/libpng-1.6.32.tar.gz'
  source_sha256 '1a8ae5c8eafad895cc3fce78fbcb6fdef663b8eb8375f04616e6496360093abb'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
      system "./configure CFLAGS=\" -fPIC\""
      system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
