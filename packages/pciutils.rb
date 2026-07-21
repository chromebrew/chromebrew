require 'package'

class Pciutils < Package
  description 'The PCI Utilities are a collection of programs for inspecting and manipulating configuration of PCI devices, all based on a common portable library libpci which offers access to the PCI configuration space on a variety of operating systems.'
  homepage 'https://mj.ucw.cz/sw/pciutils/'
  version '3.15.0'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://www.kernel.org/pub/software/utils/pciutils/pciutils-#{version}.tar.xz"
  source_sha256 'c02940f430841ecf158d5d9a50007afc4d5353c8678a2455003ca0b2c4e9f5ff'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '40dc809f5d705270bc0fa95981f57da5434a8b480cec590fbe131b56b85f9a1b',
     armv7l: '40dc809f5d705270bc0fa95981f57da5434a8b480cec590fbe131b56b85f9a1b',
       i686: '50057aad169f658270b2af8f1469c2730ca4889fa6a5b58bc432f1debb0798a4',
     x86_64: '9351bf6326f63e282987d071416a33e980455cb9b1b40e6ae14e75cbcede937b'
  })

  depends_on 'eudev' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'zlib' => :library

  def self.build
    system 'make',
           "LIBDIR=#{CREW_LIB_PREFIX}",
           "PREFIX=#{CREW_PREFIX}",
           'SHARED=yes',
           'ZLIB=yes',
           'DNS=yes'
  end

  def self.install
    system 'make',
           "LIBDIR=#{CREW_LIB_PREFIX}",
           "DESTDIR=#{CREW_DEST_DIR}",
           "PREFIX=#{CREW_PREFIX}",
           'install-lib',
           'SHARED=yes',
           'ZLIB=yes',
           'install',
           'DNS=yes'
  end
end
