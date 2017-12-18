require 'package'

class Qemu < Package
  description 'QEMU is a generic and open source machine emulator and virtualizer.'
  homepage 'http://www.qemu.org/'
  version '2.10.2'
  source_url 'https://download.qemu.org/qemu-2.10.2.tar.xz'
  source_sha256 'fcfdaa1ecdaac8aead616fe811bfb8fe4a8f2cd59796aa446c5175b5af0e829f'

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
