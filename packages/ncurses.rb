require 'package'

class Ncurses < Package
  description 'The ncurses (new curses) library is a free software emulation of curses in System V Release 4.0 (SVr4), and more.'
  homepage 'https://www.gnu.org/software/ncurses/'
  version '6.2'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/ncurses/ncurses-6.2.tar.gz'
  source_sha256 '30306e0c76e0f9f1f0de987cf1c82a5c21e1ce6568b9227f7da5b71cbea86c9d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ncurses-6.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ncurses-6.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ncurses-6.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ncurses-6.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e040d9c065046e107be2712904f0452720724254cc36aa7f04056246967b41b5',
     armv7l: 'e040d9c065046e107be2712904f0452720724254cc36aa7f04056246967b41b5',
       i686: '715c277f836a8f8f6c40736c667f63913d6e8ee005b4eb258a7a156a6b6db95a',
     x86_64: '7ac9b423de77550b4ac2fc82ce4d42fc694352d3911918ba265ca2472d595f38',
  })

  def self.build
    # build libncursesw
    system "mkdir -p ncursesw_build"
    Dir.chdir("ncursesw_build") do
      system "../configure",
             "--prefix=#{CREW_PREFIX}",
             "--libdir=#{CREW_LIB_PREFIX}",
             "--without-normal",
             "--with-shared",
             "--with-cxx-shared",
             "--without-debug",
             "--enable-pc-files",
             "--with-pkg-config-libdir=#{CREW_LIB_PREFIX}/pkgconfig",
             "--enable-widec"
      system "make"
    end

    # build libncurses
    system "mkdir -p ncurses_build"
    Dir.chdir("ncurses_build") do
      system "../configure",
             "--prefix=#{CREW_PREFIX}",
             "--libdir=#{CREW_LIB_PREFIX}",
             "--without-normal",
             "--with-shared",
             "--with-cxx-shared",
             "--without-debug",
             "--enable-pc-files",
             "--with-pkg-config-libdir=#{CREW_LIB_PREFIX}/pkgconfig",
             "--disable-db-install",
             "--without-manpages",
             "--without-progs",
             "--without-tack"
      system "make"
    end
  end

  def self.install
    Dir.chdir("ncursesw_build") do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
    Dir.chdir("ncurses_build") do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
