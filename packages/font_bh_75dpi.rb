require 'package'

class Font_bh_75dpi < Package
  description 'Standard 75dpi Bigelow and Holmes PCF fonts'
  homepage 'https://xorg.freedesktop.org/'
  version '1.0.3'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/font/font-bh-75dpi-1.0.3.tar.bz2'
  source_sha256 '3486aa51ac92c646a448fe899c5c3dae0024b1fef724d5100d52640d1cac721c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/font_bh_75dpi-1.0.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/font_bh_75dpi-1.0.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/font_bh_75dpi-1.0.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/font_bh_75dpi-1.0.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd805e4c0a8408bc8befa3641a7b9d6237fed852228c8cad214f602ef36768383',
     armv7l: 'd805e4c0a8408bc8befa3641a7b9d6237fed852228c8cad214f602ef36768383',
       i686: '6c8f588a013faf4bcfe0e8e2518681abbdc92e55efdcd5ec7466594ff18d16ac',
     x86_64: 'c0765033ef462c10f7f42f7b6f6ead1e6bc68a32796889fda266a7d08703ba17',
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
