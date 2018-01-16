require 'package'

class Libusb < Package
  description 'A cross-platform library that gives apps easy access to USB devices'
  homepage 'https://sourceforge.net/projects/libusb/'
  version '1.0.21'
  source_url 'http://downloads.sourceforge.net/project/libusb/libusb-1.0/libusb-1.0.21/libusb-1.0.21.tar.bz2'
  source_sha256 '7dce9cce9a81194b7065ee912bcd55eeffebab694ea403ffb91b67db66b1824b'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'eudev'

  def self.build
    system './configure',
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
