require 'package'

class Font_bitstream_type1 < Package
  description 'Standard Type1 Bitstream PCF fonts'
  homepage 'https://xorg.freedesktop.org/'
  version '1.0.3'
  license 'custom'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://www.x.org/releases/individual/font/font-bitstream-type1-1.0.3.tar.bz2'
  source_sha256 'c6ea0569adad2c577f140328dc3302e729cb1b1ea90cd0025caf380625f8a688'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'a5aeadbd5238efa090053c1adef4b0a07dc95c0d819ce94b978ea5df8bdb9605',
     armv7l: 'a5aeadbd5238efa090053c1adef4b0a07dc95c0d819ce94b978ea5df8bdb9605',
     x86_64: '90f9e02e3631424df3ab89b4b2bcb69e3825654e4eb4538ceac382da9a83fa60'
  })

  depends_on 'bdftopcf'
  depends_on 'font_util'
  depends_on 'mkfontscale'

  def self.build
    system "./configure #{CREW_OPTIONS} --with-fontrootdir=#{CREW_PREFIX}/share/fonts"
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
