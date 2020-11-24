require 'package'

class Font_isas_misc < Package
  description '72dpi PCF versions of the Chinese Song Ti fonts'
  homepage 'https://xorg.freedesktop.org/'
  version '1.0.3'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/font/font-isas-misc-1.0.3.tar.bz2'
  source_sha256 '5824ab4b485951107dd245b8f7717d2822f1a6dbf6cea98f1ac7f49905c0a867'

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
