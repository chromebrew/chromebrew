require 'package'

class Font_adobe_utopia_100dpi < Package
  description '100dpi Adobe Utopia PCF fonts'
  homepage 'https://xorg.freedesktop.org/'
  version '1.0.4'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/font/font-adobe-utopia-100dpi-1.0.4.tar.bz2'
  source_sha256 'd16f5e3f227cc6dd07a160a71f443559682dbc35f1c056a5385085aaec4fada5'

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
