require 'package'

class Cunit < Package
  description "CUnit is a system for writing, administering, and running unit tests in C.\n It is built as a static library which is linked with the user's testing code."
  homepage 'https://sourceforge.net/projects/cunit/'
  version '2.1-3'
  source_url 'https://sourceforge.net/projects/cunit/files/CUnit/2.1-3/CUnit-2.1-3.tar.bz2'
  source_sha256 'f5b29137f845bb08b77ec60584fdb728b4e58f1023e6f249a464efa49a40f214'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'ncurses'
  depends_on 'ncursesw'

  def self.build
    system "autoreconf -i"
    system "CFLAGS=\"-I#{CREW_PREFIX}/include/ncurses\" ./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} --enable-curses"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
