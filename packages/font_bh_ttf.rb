require 'package'

class Font_bh_ttf < Package
  description 'Standard Bigelow and Holmes TrueType fonts'
  homepage 'https://xorg.freedesktop.org/'
  version '1.0.3'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/font/font-bh-ttf-1.0.3.tar.bz2'
  source_sha256 '1b4bea63271b4db0726b5b52c97994c3313b6023510349226908090501abd25f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/font_bh_ttf-1.0.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/font_bh_ttf-1.0.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/font_bh_ttf-1.0.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/font_bh_ttf-1.0.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'fcb876e84a386eea475d5f9f9533c3f689e90ce16b8329495a24f28a698b29fa',
     armv7l: 'fcb876e84a386eea475d5f9f9533c3f689e90ce16b8329495a24f28a698b29fa',
       i686: '6758e70d14c700ca6694a70d5764ccfccbb91f901ebc08d1f3a9dcc013811efa',
     x86_64: '6418dc920fcde48ed1bc5d914321a0be756f127d4b532e44f4482180e52cc01f',
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
