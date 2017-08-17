require 'package'

class Pciutils < Package
  description 'The PCI Utilities are a collection of programs for inspecting and manipulating configuration of PCI devices, all based on a common portable library libpci which offers access to the PCI configuration space on a variety of operating systems.'
  homepage 'http://mj.ucw.cz/sw/pciutils/'
  version '3.5.5'
  source_url 'https://www.kernel.org/pub/software/utils/pciutils/pciutils-3.5.5.tar.xz'
  source_sha256 '1d62f8fa192f90e61c35a6fc15ff3cb9a7a792f782407acc42ef67817c5939f5'

  def self.build
    system "make", "PREFIX=/usr/local", "SHARED=yes"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
