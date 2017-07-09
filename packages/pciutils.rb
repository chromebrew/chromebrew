require 'package'

class Pciutils < Package
  description 'The PCI Utilities are a collection of programs for inspecting and manipulating configuration of PCI devices, all based on a common portable library libpci which offers access to the PCI configuration space on a variety of operating systems.'
  homepage 'http://mj.ucw.cz/sw/pciutils/'
  version '3.5.2'
  source_url 'https://www.kernel.org/pub/software/utils/pciutils/pciutils-3.5.2.tar.xz'
  source_sha256 '3a99141a9f40528d0a0035665a06dc37ddb1ae341658e51b50a76ecf86235efc'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/pciutils-3.5.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/pciutils-3.5.2-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/pciutils-3.5.2-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/pciutils-3.5.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b1c4185a986c008961ad214d0d11fe408a51c9c88263b77842d01bc6a89b3aee',
     armv7l: 'b1c4185a986c008961ad214d0d11fe408a51c9c88263b77842d01bc6a89b3aee',
       i686: 'ec0680472d85c8c8773f7d4ac279c86ac04910b9bf564107f0ca84968023f58e',
     x86_64: 'db9e3b5b05bc129bf6624f014124c0e5c8f2960a821cfe027c148da2183b901a',
  })

  def self.build
    system "make", "PREFIX=/usr/local", "SHARED=yes"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
