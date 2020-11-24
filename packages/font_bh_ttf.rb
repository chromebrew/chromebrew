require 'package'

class Font_bh_ttf < Package
  description 'Standard Bigelow and Holmes TrueType fonts'
  homepage 'https://xorg.freedesktop.org/'
  version '1.0.3'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/font/font-bh-ttf-1.0.3.tar.bz2'
  source_sha256 '1b4bea63271b4db0726b5b52c97994c3313b6023510349226908090501abd25f'

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
