require 'package'

class Font_bh_lucidatypewriter_75dpi < Package
  description '75dpi Bigelow and Holmes Lucida Typewriter PCF fonts'
  homepage 'https://xorg.freedesktop.org/'
  version '1.0.3'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/font/font-bh-lucidatypewriter-75dpi-1.0.3.tar.bz2'
  source_sha256 '4ac16afbe205480cc5572e2977ea63488c543d05be0ea8e5a94c845a6eebcb31'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/font_bh_lucidatypewriter_75dpi/1.0.3_armv7l/font_bh_lucidatypewriter_75dpi-1.0.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/font_bh_lucidatypewriter_75dpi/1.0.3_armv7l/font_bh_lucidatypewriter_75dpi-1.0.3-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/font_bh_lucidatypewriter_75dpi/1.0.3_i686/font_bh_lucidatypewriter_75dpi-1.0.3-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/font_bh_lucidatypewriter_75dpi/1.0.3_x86_64/font_bh_lucidatypewriter_75dpi-1.0.3-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '28c150d55d5a1b5323eab5e908191646025ea3ed7a2590a90aef74cebf6787d2',
     armv7l: '28c150d55d5a1b5323eab5e908191646025ea3ed7a2590a90aef74cebf6787d2',
       i686: '35b5af9ccc01dd740047de1eb0948a5a3f6bd20d0f5f91f5d2f06e69350b9c92',
     x86_64: 'f6dc723b1c2385095421d1534e2fc20cdeba5515739ad8d9277e281b8c8817e8'
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
