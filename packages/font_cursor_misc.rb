require 'package'

class Font_cursor_misc < Package
  description 'Standard X11 cursors in PCF format'
  homepage 'https://xorg.freedesktop.org/'
  version '1.0.3'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/font/font-cursor-misc-1.0.3.tar.bz2'
  source_sha256 '17363eb35eece2e08144da5f060c70103b59d0972b4f4d77fd84c9a7a2dba635'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/font_cursor_misc-1.0.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/font_cursor_misc-1.0.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/font_cursor_misc-1.0.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/font_cursor_misc-1.0.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8259c1415c5c26cd3acfe4b4e285ee51e359e3a9e293ad5ee1e323b183e29447',
     armv7l: '8259c1415c5c26cd3acfe4b4e285ee51e359e3a9e293ad5ee1e323b183e29447',
       i686: 'b4ed16c23140f1937e1f1db8a50be8c3f092b5213bee32f5e02225413035876d',
     x86_64: 'de3f59c6773fbb5ac70367e766d82156b2174e6ee70fe05e2f5b49508459264a',
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
