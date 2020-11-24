require 'package'

class Font_cursor_misc < Package
  description 'Standard X11 cursors in PCF format'
  homepage 'https://xorg.freedesktop.org/'
  version '1.0.3'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/font/font-cursor-misc-1.0.3.tar.bz2'
  source_sha256 '17363eb35eece2e08144da5f060c70103b59d0972b4f4d77fd84c9a7a2dba635'

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
