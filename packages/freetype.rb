require 'package'

class Freetype < Package
  description 'FreeType is a freely available software library to render fonts.'
  homepage 'https://www.freetype.org/'
  version '2.8.1'
  source_url 'http://download.savannah.gnu.org/releases/freetype/freetype-2.8.1.tar.bz2'
  source_sha256 'e5435f02e02d2b87bb8e4efdcaa14b1f78c9cf3ab1ed80f94b6382fb6acc7d78'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/freetype-2.8.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/freetype-2.8.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/freetype-2.8.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/freetype-2.8.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '546fad37ce6175025b1aeff483724947a875068956b09559e5928e4e832dff5f',
     armv7l: '546fad37ce6175025b1aeff483724947a875068956b09559e5928e4e832dff5f',
       i686: 'e24ed13abdf73e914931169f0c76dd47504f049bc2ac1da04cffd6acea4238b8',
     x86_64: '631522861991d45dcab6564cba206681e7dcfe3f4d796a13f6ff78d5695f39c9',
  })

  depends_on 'expat'

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
