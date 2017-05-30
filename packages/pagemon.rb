require 'package'

class Pagemon < Package
  description 'Pagemon is an interactive memory/page monitoring tool allowing one to browse the memory map of an active running process.'
  homepage 'http://kernel.ubuntu.com/~cking/pagemon/'
  version '0.01.10'
  source_url 'http://kernel.ubuntu.com/~cking/tarballs/pagemon/pagemon-0.01.10.tar.gz'
  source_sha1 'bc0b4c6db0e1551711e90ffa99162cbbe6217056'

  depends_on "ncurses"

  def self.build
    system "sed -i 's,/usr,/usr/local,g' Makefile"
    system "sed -i '/^CFLAGS += -Wall/s/$/ -I\\/usr\\/local\\/include\\/ncurses/' Makefile"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
