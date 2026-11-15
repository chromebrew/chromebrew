require 'package'

class Nethack < Package
  description 'Nethack is a classic roguelike. Descend through the dungeon and retrieve the Amulet of Yendor.'
  homepage 'https://www.nethack.org/'
  version '5.0.0_Released'
  license 'nethack'
  compatibility 'all'
  source_url 'https://github.com/NetHack/NetHack.git'
  git_hashtag "NetHack-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cca52c08ad04df69e1b06800e8f740c4d80d3c9b468e4303d55ec0cc17df047b',
     armv7l: 'cca52c08ad04df69e1b06800e8f740c4d80d3c9b468e4303d55ec0cc17df047b',
       i686: '9263381e36a6b3c85691978e01b6580b2db43bb92e18e95ac5540ac1247241c6',
     x86_64: '6aa97af64bdc6a09e098e8ec19f9349ee9e740a49b5029a1cef63f9ce9b9aed4'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'ncurses' => :executable

  def self.patch
    system "sed -i 's,<curses.h>,<#{CREW_PREFIX}/include/ncursesw/curses.h>,' include/wintty.h"
    system "sed -i 's,<term.h>,<#{CREW_PREFIX}/include/ncursesw/term.h>,' include/wintty.h"
    system "sed -i 's,<curses.h>,<#{CREW_PREFIX}/include/ncursesw/curses.h>,' sys/share/unixtty.c"
    system "sed -i 's,<curses.h>,<#{CREW_PREFIX}/include/ncursesw/curses.h>,' win/tty/termcap.c"
  end

  def self.build
    system 'sys/unix/setup.sh sys/unix/hints/linux.500'
    system 'make fetch-Lua'
    system 'make all'
  end

  def self.install
    system 'make install'
    FileUtils.mkdir_p CREW_DEST_HOME
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.cp_r "#{HOME}/nh", CREW_DEST_HOME
    FileUtils.ln_s "#{HOME}/nh/install/games/lib/nethackdir/nethack", "#{CREW_DEST_PREFIX}/bin/nethack"
    FileUtils.ln_s "#{HOME}/nh/install/games/lib/nethackdir/recover", "#{CREW_DEST_PREFIX}/bin/recover"
  end

  def self.postinstall
    ExitMessage.add "\nType 'nethack' to get started.\n"
  end
end
