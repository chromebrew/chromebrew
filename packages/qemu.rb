require 'package'

class Qemu < Package
  description 'QEMU is a generic and open source machine emulator and virtualizer.'
  homepage 'http://www.qemu.org/'
  version '2.12.1'
  source_url 'https://download.qemu.org/qemu-2.12.1.tar.xz'
  source_sha256 '33583800e0006cd00b78226b85be5a27c8e3b156bed2e60e83ecbeb7b9b8364f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/qemu-2.12.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/qemu-2.12.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/qemu-2.12.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/qemu-2.12.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'fb73f6f84c7d0903ec195e44e7bdca2fa91d80a64cc843e5426b6a4cb8cc0396',
     armv7l: 'fb73f6f84c7d0903ec195e44e7bdca2fa91d80a64cc843e5426b6a4cb8cc0396',
       i686: '36cd4eaee38f19222e8877b28370ad7eaea241d3e494e1b3e5e4590bf72a44c0',
     x86_64: '2a676625832deb1a4a6817d1da65e74c904e8511fa700b1b4cb1c140a81f9964',
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
