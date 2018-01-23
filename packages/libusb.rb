require 'package'

class Libusb < Package
  description 'A cross-platform library that gives apps easy access to USB devices'
  homepage 'https://sourceforge.net/projects/libusb/'
  version '1.0.21'
  source_url 'http://downloads.sourceforge.net/project/libusb/libusb-1.0/libusb-1.0.21/libusb-1.0.21.tar.bz2'
  source_sha256 '7dce9cce9a81194b7065ee912bcd55eeffebab694ea403ffb91b67db66b1824b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libusb-1.0.21-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libusb-1.0.21-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libusb-1.0.21-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libusb-1.0.21-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1ee60eca8f21386df7d8034669d189f8480e9de59bd71bc4e5631b5f5675eaf1',
     armv7l: '1ee60eca8f21386df7d8034669d189f8480e9de59bd71bc4e5631b5f5675eaf1',
       i686: '3269135ed3d2043a8d17415445c20386ad3df9b689cb333ecc29fb057c79ecf8',
     x86_64: '48e8aff964b38e7ed9b70e5c1d227ff4f7c16537d3bd199e224867560b9aaa9b',
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
