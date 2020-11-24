require 'package'

class Font_bh_lucidatypewriter_100dpi < Package
  description '100dpi Bigelow and Holmes Lucida Typewriter PCF fonts'
  homepage 'https://xorg.freedesktop.org/'
  version '1.0.3'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/font/font-bh-lucidatypewriter-100dpi-1.0.3.tar.bz2'
  source_sha256 '62a83363c2536095fda49d260d21e0847675676e4e3415054064cbdffa641fbb'

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
