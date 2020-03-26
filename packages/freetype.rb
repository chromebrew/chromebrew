require 'package'

class Freetype < Package
  description 'FreeType is a freely available software library to render fonts.'
  homepage 'https://www.freetype.org/'
  version '2.10'
  source_url 'https://namesdir.com/mirrors/nongnu/freetype/freetype-2.10.0.tar.gz'
  source_sha256 '955e17244e9b38adb0c98df66abb50467312e6bb70eac07e49ce6bd1a20e809a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/freetype-2.10-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/freetype-2.10-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/freetype-2.10-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/freetype-2.10-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3cdfc1eae6ee52f0d3c046e2a3bc01d8383d830ea48cb2f84db94caced32b2a9',
     armv7l: '3cdfc1eae6ee52f0d3c046e2a3bc01d8383d830ea48cb2f84db94caced32b2a9',
       i686: 'b3a195210ba9bc95a863956c69218b99bdcac6a276b27648ff043d5e7bf64b39',
     x86_64: '0c761037a91633e1371974ced873e59c1f847ead4416f338119761be1bbe21c7',
  })

  depends_on 'expat'
  depends_on 'libpng'   # freetype needs zlib optionally. zlib is also the dependency of libpng
  depends_on 'bz2'
  depends_on 'harfbuzz'

  def self.build
	system "sed -i 's,/usr/include/freetype2,#{CREW_PREFIX}/include/freetype2,g' configure"
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
