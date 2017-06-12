require 'package'

class Vifm < Package
  description 'Vifm is an ncurses based file manager with vi like keybindings/modes/options/commands/configuration, which also borrows some useful ideas from mutt.'
  homepage 'https://vifm.info/'
  version '0.8.2'
  source_url 'https://downloads.sourceforge.net/project/vifm/vifm/vifm-0.8.2.tar.bz2'
  source_sha1 '1ae4179b2b9a43c440290af0ecc91b9235203be7'

  depends_on "ncurses"

  def self.build
    system "./configure", \
	   "--prefix=/usr/local", \
	   "--without-gtk", \
	   "--without-X11", \
	   #"--with-curses=/usr/local/include/ncursesw" \
	   #"--with-curses-name=ncursesw" \
	   "CPPFLAGS=-I/usr/local/include/ncursesw"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" 
  end
end
