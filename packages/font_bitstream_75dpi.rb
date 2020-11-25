require 'package'

class Font_bitstream_75dpi < Package
  description 'Standard 100dpi Bitstream PCF fonts'
  homepage 'https://xorg.freedesktop.org/'
  version '1.0.3'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/font/font-bitstream-75dpi-1.0.3.tar.bz2'
  source_sha256 'ba3f5e4610c07bd5859881660753ec6d75d179f26fc967aa776dbb3d5d5cf48e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/font_bitstream_75dpi-1.0.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/font_bitstream_75dpi-1.0.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/font_bitstream_75dpi-1.0.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/font_bitstream_75dpi-1.0.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e5df678cc719b19dcb74ad1589a7d0044ba67f6df60ba72625f43fc0280304dc',
     armv7l: 'e5df678cc719b19dcb74ad1589a7d0044ba67f6df60ba72625f43fc0280304dc',
       i686: 'dbb337a5e34891f4eaef3c0baa3d667efea2ee0600b0d100ca8ae78e38c4723b',
     x86_64: '495010865f5de0b2f9f361ccaa6c1824e9114e854c01582731be00450d1fa4be',
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
