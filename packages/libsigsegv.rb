require 'package'

class Libsigsegv < Package
  version '2.10'
  source_url 'ftp.gnu.org/gnu/libsigsegv/libsigsegv-2.10.tar.gz'
  source_sha1 'b75a647a9ebda70e7a3b33583efdd550e0eac094'

  def self.build
    system "./configure --libdir=/usr/local/lib#{SHORTARCH}/ CC=\"gcc -m#{SHORTARCH}\" CFLAGS=\" -fPIC\""
    system "make"
  end

  def self.install
    system "make check"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
