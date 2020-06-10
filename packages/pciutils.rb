require 'package'

class Pciutils < Package
  description 'The PCI Utilities are a collection of programs for inspecting and manipulating configuration of PCI devices, all based on a common portable library libpci which offers access to the PCI configuration space on a variety of operating systems.'
  homepage 'https://mj.ucw.cz/sw/pciutils/'
  version '3.6.2'
  compatibility 'all'
  source_url 'https://www.kernel.org/pub/software/utils/pciutils/pciutils-3.6.2.tar.xz'
  source_sha256 'db452ec986edefd88af0d222d22f6102f8030a8633fdfe846c3ae4bde9bb93f3'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pciutils-3.6.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pciutils-3.6.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pciutils-3.6.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pciutils-3.6.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f6e98ae7fdd796945dfc130eb256ee9d1aafe9c7e6a15bcc63a2ba4d77640b62',
     armv7l: 'f6e98ae7fdd796945dfc130eb256ee9d1aafe9c7e6a15bcc63a2ba4d77640b62',
       i686: '5e3c1391e1780632c7e71c0863528e17ff65bceef211e13d486ab672e373b3c6',
     x86_64: '1aae1bf10b5fdbbdcdf5e5d04bdbab5e8e683486a8d7a569e79eee336fbb0755',
  })

  depends_on 'eudev'

  def self.build
    system 'make',
           "LIBDIR=#{CREW_LIB_PREFIX}",
           'SBINDIR=$(PREFIX)/bin',
           "PREFIX=#{CREW_PREFIX}",
           'SHARED=yes',
           'ZLIB=yes',
           'DNS=yes'
  end

  def self.install
    system 'make',
           "LIBDIR=#{CREW_LIB_PREFIX}",
           "DESTDIR=#{CREW_DEST_DIR}",
           'SBINDIR=$(PREFIX)/bin',
           "PREFIX=#{CREW_PREFIX}",
           'install-lib',
           'SHARED=yes',
           'ZLIB=yes',
           'install',
           'DNS=yes'
  end
end
