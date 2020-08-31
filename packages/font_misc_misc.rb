require 'package'

class Font_misc_misc < Package
  description 'Standard X11 fixed PCF fonts'
  homepage 'https://xorg.freedesktop.org/'
  version '1.1.2'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/font/font-misc-misc-1.1.2.tar.bz2'
  source_sha256 'b8e77940e4e1769dc47ef1805918d8c9be37c708735832a07204258bacc11794'

  depends_on 'font_util'
  depends_on 'mkfontscale'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system "make -j#{CREW_NPROC}"
  end
  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
