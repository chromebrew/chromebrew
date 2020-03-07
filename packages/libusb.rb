require 'package'

class Libusb < Package
  description 'A cross-platform library that gives apps easy access to USB devices'
  homepage 'https://sourceforge.net/projects/libusb/'
  version '1.0.23'
  source_url 'https://github.com/libusb/libusb/releases/download/v1.0.23/libusb-1.0.23.tar.bz2'
  source_sha256 'db11c06e958a82dac52cf3c65cb4dd2c3f339c8a988665110e0d24d19312ad8d'

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
