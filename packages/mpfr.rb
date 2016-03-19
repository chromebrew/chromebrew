require 'package'

class Mpfr < Package
  version '3.1.4'
  source_url 'http://ftp.gnu.org/gnu/mpfr/mpfr-3.1.4.tar.xz'
  source_sha1 'cedc0055d55b6ee4cd17e1e6119ed412520ff81a'
  
  def self.build
    system "./configure CC=\"gcc -m#{SHORTARCH}\" CFLAGS=\" -fPIC\""
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
