require 'package'

class Binclock < Package
  description 'Ncurses clock, with time displayed in colourful binary'
  homepage 'https://github.com/JohnAnthony/Binary-Clock'
  version '3883e8'
  source_url 'https://github.com/JohnAnthony/Binary-Clock/archive/3883e8876576a45162b9a128d8317b20f98c5140.tar.gz'
  source_sha256 'e8caa26437301c70bf9840901db9e46d32b99c0ec8b442562f96390e28f35408'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'ncurses'

  def self.build
    system "sed -i 's,#include <ncurses.h>,#include <#{CREW_PREFIX}/include/ncurses/ncurses.h>,' binclock.c"
    system "sed -i 's,/usr/bin,#{CREW_PREFIX}/bin,g' Makefile"
    system "sed -i 's,/usr/share,#{CREW_PREFIX}/share,g' Makefile"
    system "make"
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "mkdir -p #{CREW_DEST_PREFIX}/share/man/man1"
    system "cp binclock #{CREW_DEST_PREFIX}/bin"
    system "cp binclock.1 #{CREW_DEST_PREFIX}/share/man/man1"
  end
end
