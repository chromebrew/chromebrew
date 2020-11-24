require 'package'

class Font_bh_lucidatypewriter_75dpi < Package
  description '75dpi Bigelow and Holmes Lucida Typewriter PCF fonts'
  homepage 'https://xorg.freedesktop.org/'
  version '1.0.3'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/font/font-bh-lucidatypewriter-75dpi-1.0.3.tar.bz2'
  source_sha256 '4ac16afbe205480cc5572e2977ea63488c543d05be0ea8e5a94c845a6eebcb31'

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
