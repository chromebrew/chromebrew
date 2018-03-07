require 'package'

class Freetype < Package
  description 'FreeType is a freely available software library to render fonts.'
  homepage 'https://www.freetype.org/'
  version '2.9'
  source_url 'http://download.savannah.gnu.org/releases/freetype/freetype-2.9.tar.bz2'
  source_sha256 'e6ffba3c8cef93f557d1f767d7bc3dee860ac7a3aaff588a521e081bc36f4c8a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/freetype-2.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/freetype-2.9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/freetype-2.9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/freetype-2.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c825acb62e921aa5ef4454d4aa812d278ef7aba1b8c90b57fc07196acf9aebd3',
     armv7l: 'c825acb62e921aa5ef4454d4aa812d278ef7aba1b8c90b57fc07196acf9aebd3',
       i686: 'cda17d30f2faacf706e7bcaa218fbafbd1477a9d7551568105bc011a5d2f48d2',
     x86_64: '512f106bac604bf6648e91ba4b84378a36431dc1151ab0094bc4ebf3dbe857ed',
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
