require 'package'

class Vifm < Package
  description 'Vifm is an ncurses based file manager with vi like keybindings/modes/options/commands/configuration, which also borrows some useful ideas from mutt.'
  homepage 'https://vifm.info/'
  version '0.9'
  source_url 'https://downloads.sourceforge.net/project/vifm/vifm/vifm-0.9.tar.bz2'
  source_sha256 'ab10c99d1e4c24ff8a03c20be1c202cc15874750cc47a1614e6fe4f8d816a7fd'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'ncurses'

  def self.build
    system "./configure", \
	   "--prefix=#{CREW_PREFIX}", \
	   "--without-gtk", \
	   "--without-X11", \
	   #"--with-curses=#{CREW_PREFIX}/include/ncursesw" \
	   #"--with-curses-name=ncursesw" \
	   "CPPFLAGS=-I#{CREW_PREFIX}/include/ncursesw"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
