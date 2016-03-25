require 'package'

class Gmp < Package
  version "6.1.0"
  source_url 'http://ftp.gnu.org/gnu/gmp/gmp-6.1.0.tar.xz'
  source_sha1 '99d691607613e749aa5d7c0c2a89aeab38fec070'
  
  def self.build
    system "./configure CC=\"gcc -m#{SHORTARCH}\" CFLAGS=\" -fPIC\""
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
