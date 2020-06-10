require 'package'

class Tina < Package
  description 'Tina is a personal information manager with a curses interface.'
  homepage 'http://devel.ringlet.net/misc/tina/'
  version '0.1.12'
  compatibility 'all'
  source_url 'https://devel.ringlet.net/files/misc/tina/tina-0.1.12.tar.xz'
  source_sha256 '108cec9d1dbd938c67f3fae2e4238e12d064f1d12bd0d9debd0ee3ac79553edf'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/tina-0.1.12-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/tina-0.1.12-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/tina-0.1.12-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/tina-0.1.12-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '07d4a2cdbffe0286a98b28ee0041d6d8cdb40ca18721c8dc4aeebcfd95416559',
     armv7l: '07d4a2cdbffe0286a98b28ee0041d6d8cdb40ca18721c8dc4aeebcfd95416559',
       i686: 'decefb2b9b8b30d1e34e8b82ddb89a4a416f5613352b75342922e068f26a3344',
     x86_64: '5112dcef239f9f6e8b68eb420529d01e889fe84ae9f009e86bc21030096e2273',
  })

  def self.build
    system "sed -i 's,<curses.h>,<#{CREW_PREFIX}/include/ncurses/curses.h>,' curslib.c"
    system "sed -i 's,<curses.h>,<#{CREW_PREFIX}/include/ncurses/curses.h>,' error.c"
    system "sed -i 's,<curses.h>,<#{CREW_PREFIX}/include/ncurses/curses.h>,' main.c"
    system "sed -i 's,<curses.h>,<#{CREW_PREFIX}/include/ncurses/curses.h>,' view.c"
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
