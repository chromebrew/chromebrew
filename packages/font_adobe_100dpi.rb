require 'package'

class Font_adobe_100dpi < Package
  description 'Standard 100dpi Adobe PCF fonts'
  homepage 'https://xorg.freedesktop.org/'
  version '1.0.3'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/font/font-adobe-100dpi-1.0.3.tar.bz2'
  source_sha256 'b2c08433eab5cb202470aa9f779efefce8d9cab2534f34f3aa4a31d05671c054'

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
