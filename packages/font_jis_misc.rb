require 'package'

class Font_jis_misc < Package
  description '78dpi PCF versions of the Japanese fixed fonts'
  homepage 'https://xorg.freedesktop.org/'
  version '1.0.3'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/font/font-jis-misc-1.0.3.tar.bz2'
  source_sha256 '2b18ce10b367ebafe95a17de799b6db9a24e2337188d124adaf68af05b1fac65'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/font_jis_misc-1.0.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/font_jis_misc-1.0.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/font_jis_misc-1.0.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/font_jis_misc-1.0.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5b076de8ecbaf59eec8e7c58657742a0cd6c9d4b874a188d2ea59fca40832302',
     armv7l: '5b076de8ecbaf59eec8e7c58657742a0cd6c9d4b874a188d2ea59fca40832302',
       i686: '023d76e3324d1daca014d7985c99d15ac537ab6b6e357ee8e870847f5bd7744f',
     x86_64: '829051dc56b5b93dc942dbd429ca93e4e14c0c5e810aa7e566fa26b434a46cf5',
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
