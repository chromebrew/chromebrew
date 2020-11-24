require 'package'

class Font_bitstream_75dpi < Package
  description 'Standard 100dpi Bitstream PCF fonts'
  homepage 'https://xorg.freedesktop.org/'
  version '1.0.3'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/font/font-bitstream-75dpi-1.0.3.tar.bz2'
  source_sha256 'ba3f5e4610c07bd5859881660753ec6d75d179f26fc967aa776dbb3d5d5cf48e'

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
