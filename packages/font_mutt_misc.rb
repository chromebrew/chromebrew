require 'package'

class Font_mutt_misc < Package
  description '100dpi PCF versions of the ClearlyU fonts'
  homepage 'https://xorg.freedesktop.org/'
  version '1.0.3'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/font/font-mutt-misc-1.0.3.tar.bz2'
  source_sha256 'bd5f7adb34367c197773a9801df5bce7b019664941900b2a31fbfe1ff2830f8f'

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
