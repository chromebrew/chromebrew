require 'package'

class Font_misc_misc < Package
  description 'Standard X11 fixed PCF fonts'
  homepage 'https://xorg.freedesktop.org/'
  version '1.1.2'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/font/font-misc-misc-1.1.2.tar.bz2'
  source_sha256 'b8e77940e4e1769dc47ef1805918d8c9be37c708735832a07204258bacc11794'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/font_misc_misc-1.1.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/font_misc_misc-1.1.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/font_misc_misc-1.1.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/font_misc_misc-1.1.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c7e78e79c50785db5262467c17dcfbff493624f91d61753741c3818d5a6b4542',
     armv7l: 'c7e78e79c50785db5262467c17dcfbff493624f91d61753741c3818d5a6b4542',
       i686: '806f3173793f6373f7d360c8544700e7a36a040b28cf8fb5e95cc6c07066bdb6',
     x86_64: '12a176ada97f23ed38e1186741d40908f703383cecc913b99dc032360e226000',
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
