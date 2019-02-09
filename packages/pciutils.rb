require 'package'

class Pciutils < Package
  description 'The PCI Utilities are a collection of programs for inspecting and manipulating configuration of PCI devices, all based on a common portable library libpci which offers access to the PCI configuration space on a variety of operating systems.'
  homepage 'https://mj.ucw.cz/sw/pciutils/'
  version '3.6.2'
  source_url 'https://www.kernel.org/pub/software/utils/pciutils/pciutils-3.6.2.tar.xz'
  source_sha256 'db452ec986edefd88af0d222d22f6102f8030a8633fdfe846c3ae4bde9bb93f3'

  binary_url ({
  })
  binary_sha256 ({
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
