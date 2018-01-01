require 'package'

class Pciutils < Package
  description 'The PCI Utilities are a collection of programs for inspecting and manipulating configuration of PCI devices, all based on a common portable library libpci which offers access to the PCI configuration space on a variety of operating systems.'
  homepage 'http://mj.ucw.cz/sw/pciutils/'
  version '3.5.6'
  source_url 'https://www.kernel.org/pub/software/utils/pciutils/pciutils-3.5.6.tar.xz'
  source_sha256 'f346eeb90cce0910c05b877fe49eadc760fa084c0455fd313e39d4b2c2d4bb21'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "make", "PREFIX=/usr/local", "SHARED=yes"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
