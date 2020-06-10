require 'package'

class Diffutils < Package
  description 'GNU Diffutils is a package of several programs related to finding differences between files.'
  homepage 'https://www.gnu.org/software/diffutils/'
  version '3.7'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/diffutils/diffutils-3.7.tar.xz'
  source_sha256 'b3a7a6221c3dc916085f0d205abf6b8e1ba443d4dd965118da364a1dc1cb3a26'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/diffutils-3.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/diffutils-3.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/diffutils-3.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/diffutils-3.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '814cec97d84c6558bff0cf5d92b048e76ec4b9cd1fdbff01890e0bfd8b7c261d',
     armv7l: '814cec97d84c6558bff0cf5d92b048e76ec4b9cd1fdbff01890e0bfd8b7c261d',
       i686: 'ac29008e6b865b39e33bfb05cf5d93f39b6e25cdb93a1994faa408e11965bbc6',
     x86_64: '7cd6726e32b667fb62a7a43189ca9677c3b21fd35cec8bd3d7051855605c9fce',
  })

  depends_on 'libsigsegv'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
