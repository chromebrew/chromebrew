require 'package'

class Font_util < Package
  description 'Tools for truncating and subseting of ISO10646-1 BDF fonts'
  homepage 'https://xorg.freedesktop.org'
  version '1.3.2'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/font/font-util-1.3.2.tar.bz2'
  source_sha256 '3ad880444123ac06a7238546fa38a2a6ad7f7e0cc3614de7e103863616522282'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/font_util-1.3.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/font_util-1.3.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/font_util-1.3.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/font_util-1.3.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'cdb0bcfb44dd1513f0db12b85f6b46b63ef1b937c0a7a17a4d7d4655667632bb',
     armv7l: 'cdb0bcfb44dd1513f0db12b85f6b46b63ef1b937c0a7a17a4d7d4655667632bb',
       i686: 'e53928dc50fe10c1a45adf1529bb829d96add95920b5697dbd237bc705ff5f06',
     x86_64: '56739db34fb689edc5b5aea0c360c3ffdb12aec9e9bccfbd557d7c2c27542d47',
  })

  depends_on 'util_macros'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
