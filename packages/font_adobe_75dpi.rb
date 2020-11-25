require 'package'

class Font_adobe_75dpi < Package
  description 'Standard 75pi Adobe PCF fonts'
  homepage 'https://xorg.freedesktop.org/'
  version '1.0.3'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/font/font-adobe-75dpi-1.0.3.tar.bz2'
  source_sha256 'c6024a1e4a1e65f413f994dd08b734efd393ce0a502eb465deb77b9a36db4d09'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/font_adobe_75dpi-1.0.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/font_adobe_75dpi-1.0.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/font_adobe_75dpi-1.0.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/font_adobe_75dpi-1.0.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ce42dd81802a50ef02e136b209b97c4f622f1fe1ee639ee0d34002771e95ba54',
     armv7l: 'ce42dd81802a50ef02e136b209b97c4f622f1fe1ee639ee0d34002771e95ba54',
       i686: 'e497248af07548ec3260124b7667c2ab5057b66334bf76f3b9aa43622adadef0',
     x86_64: '24a9499a17f3af0eb9f1c44ca71557b3ec8b7fa304f5955dcfbe4761ca0e97bb',
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
