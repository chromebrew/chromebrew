require 'package'

class Font_isas_misc < Package
  description '72dpi PCF versions of the Chinese Song Ti fonts'
  homepage 'https://xorg.freedesktop.org/'
  version '1.0.3'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/font/font-isas-misc-1.0.3.tar.bz2'
  source_sha256 '5824ab4b485951107dd245b8f7717d2822f1a6dbf6cea98f1ac7f49905c0a867'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/font_isas_misc-1.0.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/font_isas_misc-1.0.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/font_isas_misc-1.0.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/font_isas_misc-1.0.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '853abfd7c65dd75187f6137b6fba9154cb02f86e1c1d02c7375b89345a3682de',
     armv7l: '853abfd7c65dd75187f6137b6fba9154cb02f86e1c1d02c7375b89345a3682de',
       i686: 'c31e0cd006ddb1a45a26243d7882ff0db5c3d54bdf5642e58933d1c155467cb4',
     x86_64: 'af96111a02b892867c225abc24a44b2f56df766efdd7ff6e6e8a6825b9296f6a',
  })

  depends_on 'bdftopcf'
  depends_on 'font_util'
  depends_on 'mkfontscale'

  def self.build
    system "./configure #{CREW_OPTIONS} --with-fontrootdir=#{CREW_PREFIX}/share/fonts"
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
