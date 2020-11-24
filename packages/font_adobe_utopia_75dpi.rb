require 'package'

class Font_adobe_utopia_75dpi < Package
  description '100dpi Adobe Utopia PCF fonts'
  homepage 'https://xorg.freedesktop.org/'
  version '1.0.4'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/font/font-adobe-utopia-75dpi-1.0.4.tar.bz2'
  source_sha256 '8732719c61f3661c8bad63804ebfd54fc7de21ab848e9a26a19b1778ef8b5c94'

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
