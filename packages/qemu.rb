require 'package'

class Qemu < Package
  description 'QEMU is a generic and open source machine emulator and virtualizer.'
  homepage 'http://www.qemu.org/'
  version '2.12.0'
  source_url 'https://download.qemu.org/qemu-2.12.0.tar.xz'
  source_sha256 'e69301f361ff65bf5dabd8a19196aeaa5613c1b5ae1678f0823bdf50e7d5c6fc'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/qemu-2.12.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/qemu-2.12.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/qemu-2.12.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/qemu-2.12.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '137ecd91b0e74672566e8fb7742373f45584e434100001494f71e7b33b3d4a86',
     armv7l: '137ecd91b0e74672566e8fb7742373f45584e434100001494f71e7b33b3d4a86',
       i686: 'c024fc3cb47b501472530af2c912c01655afedd5cbe833a7e57bbfb02bffa06d',
     x86_64: '0c9723102c31bc87951612e56758a291bed7a0650d3e720962d3e50a81b07486',
  })

  depends_on 'bz2'
  depends_on 'curl'
  depends_on 'glib'
  depends_on 'gtk3'
  depends_on 'jemalloc'
  depends_on 'libaio'
  depends_on 'libcap_ng'
  depends_on 'libgcrypt'
  depends_on 'libsdl2'
  depends_on 'libusb'
  depends_on 'lzo'
  depends_on 'pixman'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
