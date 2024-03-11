require 'package'

class Font_bh_75dpi < Package
  description 'Standard 75dpi Bigelow and Holmes PCF fonts'
  homepage 'https://xorg.freedesktop.org/'
  version '1.0.3'
  license 'public-domain'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://www.x.org/releases/individual/font/font-bh-75dpi-1.0.3.tar.bz2'
  source_sha256 '3486aa51ac92c646a448fe899c5c3dae0024b1fef724d5100d52640d1cac721c'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'd805e4c0a8408bc8befa3641a7b9d6237fed852228c8cad214f602ef36768383',
     armv7l: 'd805e4c0a8408bc8befa3641a7b9d6237fed852228c8cad214f602ef36768383',
     x86_64: 'c0765033ef462c10f7f42f7b6f6ead1e6bc68a32796889fda266a7d08703ba17'
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
