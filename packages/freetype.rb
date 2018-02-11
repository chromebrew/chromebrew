require 'package'

class Freetype < Package
  description 'FreeType is a freely available software library to render fonts.'
  homepage 'https://www.freetype.org/'
  version '2.8.1'
  source_url 'http://download.savannah.gnu.org/releases/freetype/freetype-2.8.1.tar.bz2'
  source_sha256 'e5435f02e02d2b87bb8e4efdcaa14b1f78c9cf3ab1ed80f94b6382fb6acc7d78'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'expat'
  depends_on 'libpng'   # freetype needs zlib optionally. zlib is also the dependency of libpng
  depends_on 'bz2'
  
  def self.build
      system "./configure \
              CFLAGS=\" -fPIC\" \
              --prefix=#{CREW_PREFIX} \
              --libdir=#{CREW_LIB_PREFIX}"
      system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
