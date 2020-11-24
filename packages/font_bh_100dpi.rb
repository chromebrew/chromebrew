require 'package'

class Font_bh_100dpi < Package
  description 'Standard 100dpi Bigelow and Holmes PCF fonts'
  homepage 'https://xorg.freedesktop.org/'
  version '1.0.3'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/font/font-bh-100dpi-1.0.3.tar.bz2'
  source_sha256 '23c07162708e4b79eb33095c8bfa62c783717a9431254bbf44863734ea239481'

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
