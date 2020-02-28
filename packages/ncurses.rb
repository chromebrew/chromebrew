require 'package'

class Ncurses < Package
  description 'The ncurses (new curses) library is a free software emulation of curses in System V Release 4.0 (SVr4), and more.'
  homepage 'https://www.gnu.org/software/ncurses/'
  version '6.2-1'
  source_url 'https://ftpmirror.gnu.org/ncurses/ncurses-6.2.tar.gz'
  source_sha256 '30306e0c76e0f9f1f0de987cf1c82a5c21e1ce6568b9227f7da5b71cbea86c9d'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    # build libncurses
    system "mkdir -p ncurses_build"
    Dir.chdir("ncurses_build") do
      system "../configure",
             "--prefix=#{CREW_PREFIX}",
             "--libdir=#{CREW_LIB_PREFIX}",
             "--with-normal",
             "--with-shared",
             "--with-cxx-shared",
             "--without-debug",
             "--enable-pc-files",
             "--with-pkg-config-libdir=#{CREW_LIB_PREFIX}/pkgconfig",
             "--without-manpages",
             "--with-termlib"
      system "make"
    end

    # build libncursesw
    system "mkdir -p ncursesw_build"
    Dir.chdir("ncursesw_build") do
      system "../configure",
             "--prefix=#{CREW_PREFIX}",
             "--libdir=#{CREW_LIB_PREFIX}",
             "--with-normal",
             "--with-shared",
             "--with-cxx-shared",
             "--with-termlib",
             "--without-debug",
             "--enable-pc-files",
             "--with-pkg-config-libdir=#{CREW_LIB_PREFIX}/pkgconfig",
             "--enable-widec"
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
