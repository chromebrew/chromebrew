require 'package'

class Qemu < Package
  description 'QEMU is a generic and open source machine emulator and virtualizer.'
  homepage 'http://www.qemu.org/'
  version '4.2.0'
  compatibility 'all'
  source_url 'https://download.qemu.org/qemu-4.2.0.tar.xz'
  source_sha256 'd3481d4108ce211a053ef15be69af1bdd9dde1510fda80d92be0f6c3e98768f0'

  binary_url ({

  })
  binary_sha256 ({

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
