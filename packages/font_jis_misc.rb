require 'package'

class Font_jis_misc < Package
  description '78dpi PCF versions of the Japanese fixed fonts'
  homepage 'https://xorg.freedesktop.org/'
  version '1.0.3'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/font/font-jis-misc-1.0.3.tar.bz2'
  source_sha256 '2b18ce10b367ebafe95a17de799b6db9a24e2337188d124adaf68af05b1fac65'

  depends_on 'bdftopcf'
  depends_on 'font_util'
  def self.build
      system "./configure #{CREW_OPTIONS} --with-fontrootdir=#{CREW_PREFIX}/share/fonts"
      system 'make'
  end
  def self.install
      system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
