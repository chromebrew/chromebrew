require 'package'

class Pciutils < Package
  description 'The PCI Utilities are a collection of programs for inspecting and manipulating configuration of PCI devices, all based on a common portable library libpci which offers access to the PCI configuration space on a variety of operating systems.'
  homepage 'http://mj.ucw.cz/sw/pciutils/'
  version '3.5.6'
  source_url 'https://www.kernel.org/pub/software/utils/pciutils/pciutils-3.5.6.tar.xz'
  source_sha256 'f346eeb90cce0910c05b877fe49eadc760fa084c0455fd313e39d4b2c2d4bb21'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pciutils-3.5.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pciutils-3.5.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pciutils-3.5.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pciutils-3.5.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'eaca3ede010846f7abb86206a820681216390a0c2acef1e9e6c20bc28a966b65',
     armv7l: 'eaca3ede010846f7abb86206a820681216390a0c2acef1e9e6c20bc28a966b65',
       i686: '382b96cfc4f72ac99f65f653bf748532401511eecb9f62957e50f2f4ef4eb08b',
     x86_64: '9842f4c3c91ec9e60580a7658dc590c3c1c30310513b4825b6e67a5029536306',
  })

  depends_on 'zlibpkg'

  def self.build
    system "sed -i 's,SBINDIR=\$(PREFIX)/sbin,SBINDIR=#{CREW_PREFIX}/bin,' Makefile"
    system "make", "PREFIX=#{CREW_PREFIX}", "SHARED=yes", "ZLIB=yes"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "mkdir -p #{CREW_DEST_LIB_PREFIX}"
    system "cp lib/libpci.so.3.5.6 #{CREW_DEST_LIB_PREFIX}"
    system "ln -s #{CREW_LIB_PREFIX}/libpci.so.3.5.6 #{CREW_DEST_LIB_PREFIX}/libpci.so.3"
  end
end
