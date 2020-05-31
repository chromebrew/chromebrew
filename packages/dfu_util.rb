require 'package'

class Dfu_util < Package
  description 'DFU is intended to download and upload firmware to/from devices connected over USB.'
  homepage 'http://dfu-util.gnumonks.org/'
  version '0.9'
  source_url 'http://dfu-util.sourceforge.net/releases/dfu-util-0.9.tar.gz'
  source_sha256 '36428c6a6cb3088cad5a3592933385253da5f29f2effa61518ee5991ea38f833'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/dfu_util-0.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/dfu_util-0.9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/dfu_util-0.9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/dfu_util-0.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9f15f808d4e10bce99419bd7330f17af265be7db6b21919497aa1df2b235259a',
     armv7l: '9f15f808d4e10bce99419bd7330f17af265be7db6b21919497aa1df2b235259a',
       i686: '9a3d7b20e130741f7182f124fac70e458ccf7293848373bfd1808b147062fe63',
     x86_64: '0293dd440c43ca3c89f8a83c8127de0a37a1357c6515f2933f94ab1b29b5322d',
  })

  depends_on 'libusb'

  def self.build
    system "./configure \
      --prefix=#{CREW_PREFIX} \
      --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
