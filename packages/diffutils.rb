require 'package'

class Diffutils < Package
  description 'GNU Diffutils is a package of several programs related to finding differences between files.'
  homepage 'http://www.gnu.org/software/diffutils/'
  version '3.7'
  source_url 'https://ftp.gnu.org/gnu/diffutils/diffutils-3.7.tar.xz'
  source_sha256 'b3a7a6221c3dc916085f0d205abf6b8e1ba443d4dd965118da364a1dc1cb3a26'

  binary_url ({
  })
  binary_sha256 ({
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
