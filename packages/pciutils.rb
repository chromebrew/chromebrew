require 'package'

class Pciutils < Package
  description 'The PCI Utilities are a collection of programs for inspecting and manipulating configuration of PCI devices, all based on a common portable library libpci which offers access to the PCI configuration space on a variety of operating systems.'
  homepage 'http://mj.ucw.cz/sw/pciutils/'
  version '3.5.2'
  source_url 'https://www.kernel.org/pub/software/utils/pciutils/pciutils-3.5.2.tar.xz'
  source_sha1 '29d9a75ce2a2d92721b6e92c7c89236b4c91041f'

  def self.build
    system "make", "PREFIX=/usr/local", "SHARED=yes"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
