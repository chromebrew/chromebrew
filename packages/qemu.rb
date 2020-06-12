require 'package'

class Qemu < Package
  description 'QEMU is a generic and open source machine emulator and virtualizer.'
  homepage 'http://www.qemu.org/'
  version '3.1.0'
  compatibility 'all'
  source_url 'https://download.qemu.org/qemu-3.1.0.tar.xz'
  source_sha256 '6a0508df079a0a33c2487ca936a56c12122f105b8a96a44374704bef6c69abfc'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/qemu-3.1.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/qemu-3.1.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/qemu-3.1.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/qemu-3.1.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '23aa474b3f63e9f5825a77323b4bf7b5b710022e055ea97c524fa3d32cfc36cb',
     armv7l: '23aa474b3f63e9f5825a77323b4bf7b5b710022e055ea97c524fa3d32cfc36cb',
       i686: '600b31eaeb4a55c8fe73a1a8e2645ad44bfa166c34893a24383acd76f25c1579',
     x86_64: 'fe691d318fb71461e3ce85a733165bea3d56749bf4fa572185dd086c9d7e97bd',
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
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           "--disable-stack-protector"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
