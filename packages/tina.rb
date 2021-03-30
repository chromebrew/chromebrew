require 'package'

class Tina < Package
  description 'Tina is a personal information manager with a curses interface.'
  homepage 'https://devel.ringlet.net/misc/tina/'
  version '0.1.12-1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://devel.ringlet.net/files/misc/tina/tina-0.1.12.tar.xz'
  source_sha256 '108cec9d1dbd938c67f3fae2e4238e12d064f1d12bd0d9debd0ee3ac79553edf'

  def self.patch
        system "sed -i 's,<curses.h>,<#{CREW_PREFIX}/include/ncursesw/curses.h>,' curslib.c"
    system "sed -i 's,<curses.h>,<#{CREW_PREFIX}/include/ncursesw/curses.h>,' error.c"
    system "sed -i 's,<curses.h>,<#{CREW_PREFIX}/include/ncursesw/curses.h>,' main.c"
    system "sed -i 's,<curses.h>,<#{CREW_PREFIX}/include/ncursesw/curses.h>,' view.c"
  end

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
