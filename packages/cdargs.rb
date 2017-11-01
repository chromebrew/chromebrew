require 'package'

class Cdargs < Package
  description 'Directory bookmarking system - Enhanced cd utilities'
  homepage 'http://www.skamphausen.de/cgi-bin/ska/CDargs'
  version '1.35'
  source_url 'http://www.skamphausen.de/downloads/cdargs/cdargs-1.35.tar.gz'
  source_sha256 'ee35a8887c2379c9664b277eaed9b353887d89480d5749c9ad957adf9c57ed2c'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'ncurses'

  def self.build
    system "sed -i 's,#include <ncurses.h>,#include <#{CREW_PREFIX}/include/ncurses/ncurses.h>,' configure"
    system "sed -i 's,# include <ncurses.h>,#include <#{CREW_PREFIX}/include/ncurses/ncurses.h>,' src/cdargs.cc"
    system "./configure --prefix=#{CREW_PREFIX} --with-ncurses"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
