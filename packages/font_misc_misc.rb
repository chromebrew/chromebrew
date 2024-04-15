require 'package'

class Font_misc_misc < Package
  description 'Standard X11 fixed PCF fonts'
  homepage 'https://xorg.freedesktop.org/'
  version '1.1.2'
  license 'custom'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://www.x.org/releases/individual/font/font-misc-misc-1.1.2.tar.bz2'
  source_sha256 'b8e77940e4e1769dc47ef1805918d8c9be37c708735832a07204258bacc11794'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'c7e78e79c50785db5262467c17dcfbff493624f91d61753741c3818d5a6b4542',
     armv7l: 'c7e78e79c50785db5262467c17dcfbff493624f91d61753741c3818d5a6b4542',
     x86_64: '12a176ada97f23ed38e1186741d40908f703383cecc913b99dc032360e226000'
  })

  depends_on 'bdftopcf'
  depends_on 'font_util'
  depends_on 'mkfontscale'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
