require 'package'

class Freetype < Package
  description 'FreeType is a freely available software library to render fonts.'
  homepage 'https://www.freetype.org/'
  version '2.9-0'
  source_url 'http://download.savannah.gnu.org/releases/freetype/freetype-2.9.tar.bz2'
  source_sha256 'e6ffba3c8cef93f557d1f767d7bc3dee860ac7a3aaff588a521e081bc36f4c8a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/freetype-2.9-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/freetype-2.9-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/freetype-2.9-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/freetype-2.9-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7fd752cc084ee8a101030e682b0dbce39551049fddbf547762b6f8e60450e131',
     armv7l: '7fd752cc084ee8a101030e682b0dbce39551049fddbf547762b6f8e60450e131',
       i686: '1c2688c3070e37d61db309a6310a5a613aa89c419a89cbc79d9055b56c1c82fc',
     x86_64: '1490d08a9b385ef3abc323c914aaf218f0b59961885e3cda64278d971ace71c9',
  })

  depends_on 'expat'
  depends_on 'libpng'   # freetype needs zlib optionally. zlib is also the dependency of libpng
  depends_on 'bz2'
  depends_on 'harfbuzz'

  def self.build
    system "./configure \
            CFLAGS=\" -fPIC\" \
            --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX} \
            --with-harfbuzz"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
