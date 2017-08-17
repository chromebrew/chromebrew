require 'package'

class Pciutils < Package
  description 'The PCI Utilities are a collection of programs for inspecting and manipulating configuration of PCI devices, all based on a common portable library libpci which offers access to the PCI configuration space on a variety of operating systems.'
  homepage 'http://mj.ucw.cz/sw/pciutils/'
  version '3.5.2'
  source_url 'https://www.kernel.org/pub/software/utils/pciutils/pciutils-3.5.2.tar.xz'
  source_sha256 '3a99141a9f40528d0a0035665a06dc37ddb1ae341658e51b50a76ecf86235efc'

  def self.build
    system "make", "PREFIX=/usr/local", "SHARED=yes"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
