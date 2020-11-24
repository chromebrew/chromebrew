require 'package'

class Font_bh_type1 < Package
  description 'Standard Bigelow and Holmes Type1 fonts'
  homepage 'https://xorg.freedesktop.org/'
  version '1.0.3'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/font/font-bh-type1-1.0.3.tar.bz2'
  source_sha256 '761455a297486f3927a85d919b5c948d1d324181d4bea6c95d542504b68a63c1'

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
