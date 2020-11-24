require 'package'

class Font_bitstream_type1 < Package
  description 'Standard Type1 Bitstream PCF fonts'
  homepage 'https://xorg.freedesktop.org/'
  version '1.0.3'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/font/font-bitstream-type1-1.0.3.tar.bz2'
  source_sha256 'c6ea0569adad2c577f140328dc3302e729cb1b1ea90cd0025caf380625f8a688'

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
