require 'package'

class Qemu < Package
  description 'QEMU is a generic and open source machine emulator and virtualizer.'
  homepage 'http://www.qemu.org/'
  version '2.11.1'
  source_url 'https://download.qemu.org/qemu-2.11.1.tar.xz'
  source_sha256 '8a5145d1f8bd2eadc6776f3e13c68cd28d01349e30639bdbcb26ac588d668686'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/qemu-2.11.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/qemu-2.11.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/qemu-2.11.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/qemu-2.11.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3c0b57023d9ef4b8060f80108fb8eed1d22249bbde9ccef07b1d56879cc4cd4e',
     armv7l: '3c0b57023d9ef4b8060f80108fb8eed1d22249bbde9ccef07b1d56879cc4cd4e',
       i686: 'aa73560654924273adbc35953221cd3c0a2e71f47e4b0a46052d94d22e063cae',
     x86_64: '755eab8c88e5791fc672639c4098225a313a27cc9799e629365076917b74a2d0',
  })

  depends_on 'automake' => :build
  depends_on 'bison' => :build
  depends_on 'diffutils' => :build
  depends_on 'flex' => :build
  depends_on 'libtool' => :build
  depends_on 'gettext'
  depends_on 'glib'
  depends_on 'pixman'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
