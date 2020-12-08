require 'package'

class Ncurses < Package
  description 'The ncurses (new curses) library is a free software emulation of curses in System V Release 4.0 (SVr4), and more.'
  homepage 'https://www.gnu.org/software/ncurses/'
  version '6.2-20201205'
  compatibility 'all'
  source_url 'https://github.com/mirror/ncurses/archive/42259b594b5dabd37fe2bc294051d2db82e873a2.zip'
  source_sha256 '782bd5e77fb795f505d6ffd3e443da1cd0ffd6ebb36588a3b7e81e7da34bf340'


  def self.build
    # build libncursesw
    FileUtils.mkdir_p "ncursesw_build"
    Dir.chdir("ncursesw_build") do
      system "../configure",
             "--prefix=#{CREW_PREFIX}",
             "--libdir=#{CREW_LIB_PREFIX}",
             "--with-shared",
             "--with-cxx-shared",
             "--without-debug",
             "--enable-pc-files",
             "--with-pkg-config-libdir=#{CREW_LIB_PREFIX}/pkgconfig",
             "--enable-widec",
             "--without-tests",
             "--with-termlib"
      system "make"
    end

    # build libncurses
    FileUtils.mkdir_p "ncurses_build"
    Dir.chdir("ncurses_build") do
      system "../configure",
             "--prefix=#{CREW_PREFIX}",
             "--libdir=#{CREW_LIB_PREFIX}",
             "--with-shared",
             "--with-cxx-shared",
             "--without-debug",
             "--enable-pc-files",
             "--with-pkg-config-libdir=#{CREW_LIB_PREFIX}/pkgconfig",
             "--disable-db-install",
             "--without-manpages",
             "--without-progs",
             "--without-tack",
             "--without-tests",
             "--with-termlib"
      system "make"
    end
  end

  def self.install
    Dir.chdir("ncursesw_build") do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
      FileUtils.ln_sf "#{CREW_LIB_PREFIX}/libtinfow.so.6", "#{CREW_DEST_LIB_PREFIX}/libtinfow.so.5"
    end
    Dir.chdir("ncurses_build") do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
      FileUtils.ln_sf "#{CREW_LIB_PREFIX}/libtinfo.so.6", "#{CREW_DEST_LIB_PREFIX}/libtinfo.so.5"
    end
  end
end
