require 'package'

class Font_bitstream_100dpi < Package
  description 'Standard 100dpi Bitstream PCF fonts'
  homepage 'https://xorg.freedesktop.org/'
  version '1.0.3'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/font/font-bitstream-100dpi-1.0.3.tar.bz2'
  source_sha256 'ebe0d7444e3d7c8da7642055ac2206f0190ee060700d99cd876f8fc9964cb6ce'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/font_bitstream_100dpi-1.0.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/font_bitstream_100dpi-1.0.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/font_bitstream_100dpi-1.0.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/font_bitstream_100dpi-1.0.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f441acd2dbd2a14fbf1f8a9751c280914430fb1fca73226e9d41f6942d148584',
     armv7l: 'f441acd2dbd2a14fbf1f8a9751c280914430fb1fca73226e9d41f6942d148584',
       i686: 'a624d6c5904592ce3cbd6fc12a8256637f0901e8d3c43e00761a6cce6dd5d857',
     x86_64: 'b77710477235aae88b224494b18cf17b14789916bdf4f4f4b7397e3885a9a347',
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
