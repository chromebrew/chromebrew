require 'package'

class Font_bh_75dpi < Package
  description 'Standard 75dpi Bigelow and Holmes PCF fonts'
  homepage 'https://xorg.freedesktop.org/'
  version '1.0.3'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/font/font-bh-75dpi-1.0.3.tar.bz2'
  source_sha256 '3486aa51ac92c646a448fe899c5c3dae0024b1fef724d5100d52640d1cac721c'

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
