require 'package'

class Font_dec_misc < Package
  description 'DEC cursor and session PCF fonts'
  homepage 'https://xorg.freedesktop.org/'
  version '1.0.3'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/font/font-dec-misc-1.0.3.tar.bz2'
  source_sha256 'e19ddf8b5f8de914d81675358fdfe37762e9ce524887cc983adef34f2850ff7b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/font_dec_misc-1.0.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/font_dec_misc-1.0.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/font_dec_misc-1.0.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/font_dec_misc-1.0.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e9bd304b0a670711ef40a84c9464c3f27778b111848728a2915a0e347955245e',
     armv7l: 'e9bd304b0a670711ef40a84c9464c3f27778b111848728a2915a0e347955245e',
       i686: '45c87ad2777332aa0d5e29ee1baa05fb6c84a63f2adb2e5e7306b8aa81e94e01',
     x86_64: '4c62adf9306c813a0f977d8f591762561a1e069a06b66d765ee87ecd940a481f',
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
