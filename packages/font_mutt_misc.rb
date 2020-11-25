require 'package'

class Font_mutt_misc < Package
  description '100dpi PCF versions of the ClearlyU fonts'
  homepage 'https://xorg.freedesktop.org/'
  version '1.0.3'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/font/font-mutt-misc-1.0.3.tar.bz2'
  source_sha256 'bd5f7adb34367c197773a9801df5bce7b019664941900b2a31fbfe1ff2830f8f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/font_mutt_misc-1.0.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/font_mutt_misc-1.0.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/font_mutt_misc-1.0.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/font_mutt_misc-1.0.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5a0bcf47ee4af1c9f15feb3e463f37558240558fc145e046f23c6ada4acb4a9b',
     armv7l: '5a0bcf47ee4af1c9f15feb3e463f37558240558fc145e046f23c6ada4acb4a9b',
       i686: 'be6200054fec1e6b75960c09258a33ae949a7dfdcbd159213bc6b0ddb85a92d4',
     x86_64: '318656cca427983462ba4777ce2f7104bbe843a58c2d5610888f33e462f0eda9',
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
