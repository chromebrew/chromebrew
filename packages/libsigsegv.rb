require 'package'

class Libsigsegv < Package
  description 'GNU libsigsegv is a library for handling page faults in user mode.'
  homepage 'https://www.gnu.org/software/libsigsegv/'
  version '2.11'
  source_url 'ftp://ftp.gnu.org/gnu/libsigsegv/libsigsegv-2.11.tar.gz'
  source_sha1 '186dea8ae788395476bd7cbaf38c17ebe82e1777'

  def self.build
    system "./configure", "--libdir=#{CREW_LIB_PREFIX}", "--enable-shared", "--disable-static", "--with-pic"
    system "make"
  end

  def self.install
    system "make check"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
