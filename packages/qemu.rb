require 'package'

class Qemu < Package
  description 'QEMU is a generic and open source machine emulator and virtualizer.'
  homepage 'http://www.qemu.org/'
  version '2.10.2'
  source_url 'https://download.qemu.org/qemu-2.10.2.tar.xz'
  source_sha256 'fcfdaa1ecdaac8aead616fe811bfb8fe4a8f2cd59796aa446c5175b5af0e829f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/qemu-2.10.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/qemu-2.10.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/qemu-2.10.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/qemu-2.10.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'fc371b5716a93066b585a6d4acdedb61fa0af418f5b6fd4b9403802074a6a4c0',
     armv7l: 'fc371b5716a93066b585a6d4acdedb61fa0af418f5b6fd4b9403802074a6a4c0',
       i686: 'dcdf67eb60554c25de280bd46778ac74a1b6dd33fa82c12ba024a78d97b5aed3',
     x86_64: 'b46fe6d1cf03b5e4f9c4480538ebb4fe0c96934de75913a22a3d5858b26e33ff',
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
