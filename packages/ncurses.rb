require 'package'

class Ncurses < Package
  description 'The ncurses (new curses) library is a free software emulation of curses in System V Release 4.0 (SVr4), and more.'
  homepage 'https://www.gnu.org/software/ncurses/'
  version '6.2-20201205-1'
  compatibility 'all'
  source_url 'https://github.com/mirror/ncurses/archive/42259b594b5dabd37fe2bc294051d2db82e873a2.zip'
  source_sha256 '782bd5e77fb795f505d6ffd3e443da1cd0ffd6ebb36588a3b7e81e7da34bf340'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ncurses-6.2-20201205-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ncurses-6.2-20201205-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ncurses-6.2-20201205-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ncurses-6.2-20201205-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
  })

  def self.build
    # build libncursesw
    FileUtils.mkdir 'ncursesw_build'
    Dir.chdir 'ncursesw_build' do
      system '../configure',
             "--prefix=#{CREW_PREFIX}",
             "--libdir=#{CREW_LIB_PREFIX}",
             '--with-shared',
             '--with-cxx-shared',
             '--without-debug',
             '--enable-pc-files',
             "--with-pkg-config-libdir=#{CREW_LIB_PREFIX}/pkgconfig",
             '--enable-widec',
             '--without-tests',
             '--with-termlib'
      system 'make'
    end

    # build libncurses
    FileUtils.mkdir 'ncurses_build'
    Dir.chdir 'ncurses_build' do
      system '../configure',
             "--prefix=#{CREW_PREFIX}",
             "--libdir=#{CREW_LIB_PREFIX}",
             '--with-shared',
             '--with-cxx-shared',
             '--without-debug',
             '--enable-pc-files',
             "--with-pkg-config-libdir=#{CREW_LIB_PREFIX}/pkgconfig",
             '--disable-db-install',
             '--without-manpages',
             '--without-progs',
             '--without-tack',
             '--without-tests',
             '--with-termlib'
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'ncursesw_build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
    Dir.chdir 'ncurses_build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
