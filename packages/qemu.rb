require 'package'

class Qemu < Package
  description 'QEMU is a generic and open source machine emulator and virtualizer.'
  homepage 'http://www.qemu.org/'
  version '2.10.1'
  source_url 'https://download.qemu.org/qemu-2.10.1.tar.xz'
  source_sha256 '1dd51a908fc68c7d935b0b31fb184c5669bc23b5a1b081816e824714f2a11caa'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'automake' => :build
  depends_on 'bison' => :build
  depends_on 'diffutils' => :build
  depends_on 'flex' => :build
  depends_on 'libtool' => :build
  depends_on 'gettext'
  depends_on 'glib'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
