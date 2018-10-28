require 'package'

class Qemu < Package
  description 'QEMU is a generic and open source machine emulator and virtualizer.'
  homepage 'http://www.qemu.org/'
  version '3.0.0'
  source_url 'https://download.qemu.org/qemu-3.0.0.tar.xz'
  source_sha256 '8d7af64fe8bd5ea5c3bdf17131a8b858491bcce1ee3839425a6d91fb821b5713'

  binary_url ({
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/qemu-3.0.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     x86_64: '3f5e0ad3cae968281e720a3351157e7e72ee275a403d89cce4dc0090f13a08dc',
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
  depends_on 'hicolor_icon_theme'

  def self.build
    system "./configure",
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           "--disable-stack-protector"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
