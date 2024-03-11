require 'package'

class Font_bh_lucidatypewriter_75dpi < Package
  description '75dpi Bigelow and Holmes Lucida Typewriter PCF fonts'
  homepage 'https://xorg.freedesktop.org/'
  version '1.0.3'
  license 'public-domain'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://www.x.org/releases/individual/font/font-bh-lucidatypewriter-75dpi-1.0.3.tar.bz2'
  source_sha256 '4ac16afbe205480cc5572e2977ea63488c543d05be0ea8e5a94c845a6eebcb31'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '28c150d55d5a1b5323eab5e908191646025ea3ed7a2590a90aef74cebf6787d2',
     armv7l: '28c150d55d5a1b5323eab5e908191646025ea3ed7a2590a90aef74cebf6787d2',
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
