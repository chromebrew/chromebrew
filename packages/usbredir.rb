# Adapted from Arch Linux usbredir PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/usbredir/trunk/PKGBUILD

require 'package'

class Usbredir < Package
  description 'USB traffic redirection protocol'
  homepage 'https://spice-space.org/page/UsbRedir'
  version '0.9.0'
  license 'GPL2 LGPL2.1'
  compatibility 'all'
  source_url 'https://spice-space.org/download/usbredir/usbredir-0.9.0.tar.xz'
  source_sha256 'a3e167bf42bc7fe02c3c9db27d7767f1b8ce41b99ad14a4b0d0a60abe8bf56a6'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'f21a861ddc071fe6979a0d3d2241447b763e23a437c432b6b41c9e74ee0d2848',
     armv7l: 'f21a861ddc071fe6979a0d3d2241447b763e23a437c432b6b41c9e74ee0d2848',
       i686: 'ac66c1bf406fcfb0daf14133290b171598eed9100c457fa882f0cbdcc87d3860',
     x86_64: '22a25352e6f452b061ed4350d72d06997c8032ce18f1976e8d21fab7e211d609'
  })

  depends_on 'libusb'

  def self.build
    system 'autoreconf -fi'
    system "env #{CREW_ENV_OPTIONS} \
      ./configure #{CREW_OPTIONS} \
      --sbindir=#{CREW_PREFIX}/bin"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR}/ install"
  end
end
