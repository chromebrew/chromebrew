require 'package'

class Diffutils < Package
  description 'GNU Diffutils is a package of several programs related to finding differences between files.'
  homepage 'http://www.gnu.org/software/diffutils/'
  version '3.5-1'
  source_url 'ftp://ftp.gnu.org/gnu/diffutils/diffutils-3.5.tar.xz'
  source_sha1 '1169cce8eaaf7290dc087d65db7ed75de0dceb93'

  depends_on "libsigsegv"

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-strip"
  end

  def self.check
    system "make", "check"
  end
end
