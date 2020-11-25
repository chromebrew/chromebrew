require 'package'

class Font_daewoo_misc < Package
  description 'Daewoo Gothic PCF format'
  homepage 'https://xorg.freedesktop.org/'
  version '1.0.3'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/font/font-daewoo-misc-1.0.3.tar.bz2'
  source_sha256 'bc65de70bee12698caa95b523d3b652c056347e17b68cc8b5d6bbdff235c4be8'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/font_daewoo_misc-1.0.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/font_daewoo_misc-1.0.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/font_daewoo_misc-1.0.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/font_daewoo_misc-1.0.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ab4e6485bc9457a2bce6d7f9ebd426048a7844539f8538a0b703ceb84128e746',
     armv7l: 'ab4e6485bc9457a2bce6d7f9ebd426048a7844539f8538a0b703ceb84128e746',
       i686: 'da1530601e1558c7766e1f8dad6885065ff5de0ab82368d7dec82cf309a3da4c',
     x86_64: '9477310018acb565a629602ae131766100dac22e8f3f78bd1305d3e96287f373',
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
