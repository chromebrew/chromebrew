# Adapted from Arch Linux libcacard PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libcacard/trunk/PKGBUILD

require 'package'

class Libcacard < Package
  description 'Common Access Card library that provides emulation of smart cards to a virtual card reader running in a guest virtual machine'
  homepage 'https://www.spice-space.org/page/Libcacard'
  version '2.7.0-2'
  license 'GPL2'
  compatibility 'all'
  source_url 'https://www.spice-space.org/download/libcacard/libcacard-2.7.0.tar.xz'
  source_sha256 '16b1a0847d5f9d2290e0785eca40f2e49d1ed80814bfc758c05c76b3c89cdb6f'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'a6a77ce44bca8e06cc0c2cd1b4257cdefdf57921010bd31f2b09b934014190bf',
     armv7l: 'a6a77ce44bca8e06cc0c2cd1b4257cdefdf57921010bd31f2b09b934014190bf',
       i686: '74dc747f77049f55a1d7cca619c06176d9421cca4e4d2d84ef3eab2a52c22423',
     x86_64: '0b40afbc39de9d9ec3e666943363ddae98ab4e16ac9f995a86e9982f76bf063e'
  })

  depends_on 'nss'

  def self.build
    system 'filefix'
    system "env #{CREW_ENV_OPTIONS} \
        ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
