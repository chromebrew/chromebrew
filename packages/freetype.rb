require 'package'

class Freetype < Package
  description 'FreeType is a freely available software library to render fonts.'
  homepage 'https://www.freetype.org/'
  version '2.8.1-1'
  source_url 'http://download.savannah.gnu.org/releases/freetype/freetype-2.8.1.tar.bz2'
  source_sha256 'e5435f02e02d2b87bb8e4efdcaa14b1f78c9cf3ab1ed80f94b6382fb6acc7d78'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/freetype-2.8.1-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/freetype-2.8.1-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/freetype-2.8.1-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/freetype-2.8.1-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8657d60e87d6270770370830eb311a72bf853b172a4a9691f26c2fe98cd50cd4',
     armv7l: '8657d60e87d6270770370830eb311a72bf853b172a4a9691f26c2fe98cd50cd4',
       i686: '5e68d747b4bf36882199a85ebc525e34b45e22aac6a383eb9a42b54c3af7b87a',
     x86_64: '53286345d66fea56845a266200f3604c5c7ef4c1df42510380eb09fd48cd19f0',
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
