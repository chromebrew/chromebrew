require 'package'

class Font_daewoo_misc < Package
  description 'Daewoo Gothic PCF format'
  homepage 'https://xorg.freedesktop.org/'
  version '1.0.3'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/font/font-daewoo-misc-1.0.3.tar.bz2'
  source_sha256 'bc65de70bee12698caa95b523d3b652c056347e17b68cc8b5d6bbdff235c4be8'

  depends_on 'bdftopcf'
  depends_on 'font_util'
  def self.build
      system "./configure #{CREW_OPTIONS} --with-fontrootdir=#{CREW_PREFIX}/share/fonts"
      system 'make'
  end
  def self.install
      system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
