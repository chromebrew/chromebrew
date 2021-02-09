require 'package'

class Ncurses < Package
  description 'The ncurses (new curses) library is a free software emulation of curses in System V Release 4.0 (SVr4), and more.'
  homepage 'https://www.gnu.org/software/ncurses/'
  version '6.2-20210206'
  compatibility 'all'
  source_url 'https://github.com/mirror/ncurses/archive/b724cdc89cf31757ab43262ecefe5242b0edc450.zip'
  source_sha256 'e5e83965329c85d8d28f9a35a71ab785fce015f42f491e7dcafbb9f36ad1eaea'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ncurses-6.2-20210206-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ncurses-6.2-20210206-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ncurses-6.2-20210206-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ncurses-6.2-20210206-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'a91b249cdad5de1d9d12497b721f6ce88c1be445e9c40c915a93046ddb21e400',
     armv7l: 'a91b249cdad5de1d9d12497b721f6ce88c1be445e9c40c915a93046ddb21e400',
       i686: '2918cff85ec7730463ba5950d2039e09c1d8579238c8b0e6d9257b5bb1f7812f',
     x86_64: '1fe01aa702bdba80d34a55f9596c60e577e54d93c0334a9e109a627210537185'
  })

  def self.build
    # build libncursesw
    FileUtils.mkdir 'ncursesw_build'
    Dir.chdir 'ncursesw_build' do
      system "env CFLAGS='-flto=auto' CXXFLAGS='-flto=auto' \
        LDFLAGS='-flto=auto' ../configure \
        #{CREW_OPTIONS} \
        --with-shared \
        --with-cxx-shared \
        --without-debug \
        --enable-pc-files \
        --with-pkg-config-libdir=#{CREW_LIB_PREFIX}/pkgconfig \
        --enable-widec \
        --without-tests \
        --with-termlib"
      system 'make'
    end

    # build libncurses
    FileUtils.mkdir 'ncurses_build'
    Dir.chdir 'ncurses_build' do
      system "env CFLAGS='-flto=auto' CXXFLAGS='-flto=auto' \
        LDFLAGS='-flto=auto' ../configure \
         #{CREW_OPTIONS} \
         --with-shared \
         --with-cxx-shared \
         --without-debug \
         --enable-pc-files \
         --with-pkg-config-libdir=#{CREW_LIB_PREFIX}/pkgconfig \
         --disable-db-install \
         --without-manpages \
         --without-progs \
         --without-tack \
         --without-tests \
         --with-termlib"
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
