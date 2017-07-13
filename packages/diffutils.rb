require 'package'

class Diffutils < Package
  description 'GNU Diffutils is a package of several programs related to finding differences between files.'
  homepage 'http://www.gnu.org/software/diffutils/'
  version '3.5-1'
  source_url 'ftp://ftp.gnu.org/gnu/diffutils/diffutils-3.5.tar.xz'
  source_sha256 'dad398ccd5b9faca6b0ab219a036453f62a602a56203ac659b43e889bec35533'

  depends_on "libsigsegv"

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
