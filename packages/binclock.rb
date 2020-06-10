require 'package'

class Binclock < Package
  description 'Ncurses clock, with time displayed in colourful binary'
  homepage 'https://github.com/JohnAnthony/Binary-Clock'
  version '3883e8'
  compatibility 'all'
  source_url 'https://github.com/JohnAnthony/Binary-Clock/archive/3883e8876576a45162b9a128d8317b20f98c5140.tar.gz'
  source_sha256 'e8caa26437301c70bf9840901db9e46d32b99c0ec8b442562f96390e28f35408'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/binclock-3883e8-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/binclock-3883e8-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/binclock-3883e8-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/binclock-3883e8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '265d4488274d213d0663f7aebb3da8c81b046edd8c6cef4101a70dcce6a39b18',
     armv7l: '265d4488274d213d0663f7aebb3da8c81b046edd8c6cef4101a70dcce6a39b18',
       i686: 'bb32dd6577ab50e82170e6b63843ef0c46290d6fd04b67482f3f604cff59ae02',
     x86_64: 'aae91be20e29e463d85d419c19ba534a0533f3b5b035a93a3060c18bf22f7c3f',
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
