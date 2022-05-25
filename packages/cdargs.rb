require 'package'

class Cdargs < Package
  description 'Directory bookmarking system - Enhanced cd utilities'
  homepage 'https://www.skamphausen.de/cgi-bin/ska/CDargs'
  version '1.35'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://www.skamphausen.de/downloads/cdargs/cdargs-1.35.tar.gz'
  source_sha256 'ee35a8887c2379c9664b277eaed9b353887d89480d5749c9ad957adf9c57ed2c'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cdargs/1.35_armv7l/cdargs-1.35-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cdargs/1.35_armv7l/cdargs-1.35-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cdargs/1.35_i686/cdargs-1.35-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cdargs/1.35_x86_64/cdargs-1.35-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '0914fa39e961340495be54984800dfc2e0dd65267985e0a6f3ceee95c03da61a',
     armv7l: '0914fa39e961340495be54984800dfc2e0dd65267985e0a6f3ceee95c03da61a',
       i686: 'b7f9f145e6ec4ddf18fb73fb87cb1c1b2a3b34736060746f191ee42644031d64',
     x86_64: 'c8d830042023c48a5935b26992219233bf7e911b5e5194bda5191db27e2c036d'
  })

  depends_on 'ncurses'

  def self.build
    system "sed -i 's,#include <ncurses.h>,#include <#{CREW_PREFIX}/include/ncurses/ncurses.h>,' configure"
    system "sed -i 's,# include <ncurses.h>,#include <#{CREW_PREFIX}/include/ncurses/ncurses.h>,' src/cdargs.cc"
    system "./configure --prefix=#{CREW_PREFIX} --with-ncurses"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
