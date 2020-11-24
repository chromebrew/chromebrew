require 'package'

class Font_dec_misc < Package
  description 'DEC cursor and session PCF fonts'
  homepage 'https://xorg.freedesktop.org/'
  version '1.0.3'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/font/font-dec-misc-1.0.3.tar.bz2'
  source_sha256 'e19ddf8b5f8de914d81675358fdfe37762e9ce524887cc983adef34f2850ff7b'

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
