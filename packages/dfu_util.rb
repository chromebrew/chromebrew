require 'package'

class Dfu_util < Package
  description 'DFU is intended to download and upload firmware to/from devices connected over USB.'
  homepage 'http://dfu-util.gnumonks.org/'
  version '0.9'
  source_url 'http://dfu-util.sourceforge.net/releases/dfu-util-0.9.tar.gz'
  source_sha256 '36428c6a6cb3088cad5a3592933385253da5f29f2effa61518ee5991ea38f833'

  binary_url ({
  })
  binary_sha256 ({
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
