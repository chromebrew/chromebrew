require 'package'

class Font_bh_100dpi < Package
  description 'Standard 100dpi Bigelow and Holmes PCF fonts'
  homepage 'https://xorg.freedesktop.org/'
  version '1.0.3'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/font/font-bh-100dpi-1.0.3.tar.bz2'
  source_sha256 '23c07162708e4b79eb33095c8bfa62c783717a9431254bbf44863734ea239481'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/font_bh_100dpi-1.0.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/font_bh_100dpi-1.0.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/font_bh_100dpi-1.0.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/font_bh_100dpi-1.0.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8e692f3da6f15d2c4a52e925771a41a805407e240fb8acb0c01c9a18a23df8c2',
     armv7l: '8e692f3da6f15d2c4a52e925771a41a805407e240fb8acb0c01c9a18a23df8c2',
       i686: '7205232f5b8e94a7c0acb98790bcb6515cf0f05158e85e2845d1225efa70b08c',
     x86_64: '4f2242e7bd89142c4da8833d0e836a8a19ed0d187cdb9e2867d7265d696e4fe2',
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
