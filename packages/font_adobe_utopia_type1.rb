require 'package'

class Font_adobe_utopia_type1 < Package
  description 'Adobe Utopia Type1 fonts'
  homepage 'https://xorg.freedesktop.org/'
  version '1.0.4'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/font/font-adobe-utopia-type1-1.0.4.tar.bz2'
  source_sha256 '979435105f897a70f8993fa02c8362160b0513366c2ab896965416f96dbb8077'

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
