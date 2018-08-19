require 'package'

class Freetype < Package
  description 'FreeType is a freely available software library to render fonts.'
  homepage 'https://www.freetype.org/'
  version '2.9.1'
  source_url 'https://download.savannah.gnu.org/releases/freetype/freetype-2.9.1.tar.gz'
  source_sha256 'ec391504e55498adceb30baceebd147a6e963f636eb617424bcfc47a169898ce'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/freetype-2.9.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/freetype-2.9.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/freetype-2.9.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/freetype-2.9.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b1f0356d2f51ea825abd4d9b3204b9aa5cc3e660451c94222284f71abd73ec7d',
     armv7l: 'b1f0356d2f51ea825abd4d9b3204b9aa5cc3e660451c94222284f71abd73ec7d',
       i686: '757f41d0bed65abdcf8a86345a54fe6a3e69a81b9d5fb7a93d78e4612ee0d1f6',
     x86_64: '2474ed8846e36917b2a1864416affb6de8dde1f8a61b1fc0a587ada3a7592fca',
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
