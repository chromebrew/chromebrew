require 'package'

class Diffutils < Package
  description 'GNU Diffutils is a package of several programs related to finding differences between files.'
  homepage 'http://www.gnu.org/software/diffutils/'
  version '3.6'
  source_url 'https://ftp.gnu.org/gnu/diffutils/diffutils-3.6.tar.xz'
  source_sha256 'd621e8bdd4b573918c8145f7ae61817d1be9deb4c8d2328a65cea8e11d783bd6'

  depends_on 'libsigsegv'

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
