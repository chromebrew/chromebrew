require 'package'

class Pciutils < Package
  description 'The PCI Utilities are a collection of programs for inspecting and manipulating configuration of PCI devices, all based on a common portable library libpci which offers access to the PCI configuration space on a variety of operating systems.'
  homepage 'http://mj.ucw.cz/sw/pciutils/'
  version '3.5.5'
  source_url 'https://www.kernel.org/pub/software/utils/pciutils/pciutils-3.5.5.tar.xz'
  source_sha256 '1d62f8fa192f90e61c35a6fc15ff3cb9a7a792f782407acc42ef67817c5939f5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pciutils-3.5.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pciutils-3.5.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pciutils-3.5.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pciutils-3.5.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'fb69cd22643e7aca50db2e799685a72b661911bba4f5355ecd93b990b4c588c8',
     armv7l: 'fb69cd22643e7aca50db2e799685a72b661911bba4f5355ecd93b990b4c588c8',
       i686: 'b192456ab12ce8c0ba998a4e5153669197831a667f038e6dcf437e3db16d7cbe',
     x86_64: 'd65b94cefe4cf908fd9fec6d35710e8b35959c6aad7332bbc33d1cdd626043c1',
  })

  def self.build
    system "make", "PREFIX=/usr/local", "SHARED=yes"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
