require 'package'

class Ncurses < Package
  description 'The ncurses (new curses) library is a free software emulation of curses in System V Release 4.0 (SVr4), and more.'
  homepage 'https://www.gnu.org/software/ncurses/'
  version '6.1-1'
  source_url 'https://ftpmirror.gnu.org/ncurses/ncurses-6.1.tar.gz'
  source_sha256 'aa057eeeb4a14d470101eff4597d5833dcef5965331be3528c08d99cebaa0d17'

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
    Dir.chdir ("#{CREW_DEST_PREFIX}/include") do
      system "bash -c \"cp #{CREW_PREFIX}/include/{ncurses,ncursesw}/* {\#\{CREW_PREFIX\},\#\{CREW_DEST_PREFIX\}}/include\""
    end
  end
end
