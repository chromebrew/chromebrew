require 'package'

class Font_bh_lucidatypewriter_100dpi < Package
  description '100dpi Bigelow and Holmes Lucida Typewriter PCF fonts'
  homepage 'https://xorg.freedesktop.org/'
  version '1.0.3'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/font/font-bh-lucidatypewriter-100dpi-1.0.3.tar.bz2'
  source_sha256 '62a83363c2536095fda49d260d21e0847675676e4e3415054064cbdffa641fbb'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/font_bh_lucidatypewriter_100dpi-1.0.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/font_bh_lucidatypewriter_100dpi-1.0.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/font_bh_lucidatypewriter_100dpi-1.0.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/font_bh_lucidatypewriter_100dpi-1.0.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '40f50aeba90dcd36651e66ec0ac771e998cf424393a9ceebbbf3f31e6f7bc7c4',
     armv7l: '40f50aeba90dcd36651e66ec0ac771e998cf424393a9ceebbbf3f31e6f7bc7c4',
       i686: '52f2327725413f968022444404648c81dae8bcc5e8e7b7426136ccd36b6b5eab',
     x86_64: 'd60bbd9fe4d5529154df2a5c640c54fe84790f8510a8a83c2c93e5b98c28e798',
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
