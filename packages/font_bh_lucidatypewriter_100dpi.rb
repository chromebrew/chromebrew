require 'package'

class Font_bh_lucidatypewriter_100dpi < Package
  description '100dpi Bigelow and Holmes Lucida Typewriter PCF fonts'
  homepage 'https://xorg.freedesktop.org/'
  version '1.0.3'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/font/font-bh-lucidatypewriter-100dpi-1.0.3.tar.bz2'
  source_sha256 '62a83363c2536095fda49d260d21e0847675676e4e3415054064cbdffa641fbb'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/font_bh_lucidatypewriter_100dpi/1.0.3_armv7l/font_bh_lucidatypewriter_100dpi-1.0.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/font_bh_lucidatypewriter_100dpi/1.0.3_armv7l/font_bh_lucidatypewriter_100dpi-1.0.3-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/font_bh_lucidatypewriter_100dpi/1.0.3_i686/font_bh_lucidatypewriter_100dpi-1.0.3-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/font_bh_lucidatypewriter_100dpi/1.0.3_x86_64/font_bh_lucidatypewriter_100dpi-1.0.3-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '40f50aeba90dcd36651e66ec0ac771e998cf424393a9ceebbbf3f31e6f7bc7c4',
     armv7l: '40f50aeba90dcd36651e66ec0ac771e998cf424393a9ceebbbf3f31e6f7bc7c4',
       i686: '52f2327725413f968022444404648c81dae8bcc5e8e7b7426136ccd36b6b5eab',
     x86_64: 'd60bbd9fe4d5529154df2a5c640c54fe84790f8510a8a83c2c93e5b98c28e798'
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
