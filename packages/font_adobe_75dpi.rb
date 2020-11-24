require 'package'

class Font_adobe_75dpi < Package
  description 'Standard 75pi Adobe PCF fonts'
  homepage 'https://xorg.freedesktop.org/'
  version '1.0.3'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/font/font-adobe-75dpi-1.0.3.tar.bz2'
  source_sha256 'c6024a1e4a1e65f413f994dd08b734efd393ce0a502eb465deb77b9a36db4d09'

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
