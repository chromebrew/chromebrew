require 'package'

class Ncurses < Package
  description 'The ncurses (new curses) library is a free software emulation of curses in System V Release 4.0 (SVr4), and more.'
  homepage 'https://www.gnu.org/software/ncurses/'
  version '6.2-20210206-1'
  compatibility 'all'
  source_url 'https://github.com/mirror/ncurses/archive/b724cdc89cf31757ab43262ecefe5242b0edc450.zip'
  source_sha256 'e5e83965329c85d8d28f9a35a71ab785fce015f42f491e7dcafbb9f36ad1eaea'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ncurses-6.2-20210206-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ncurses-6.2-20210206-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ncurses-6.2-20210206-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ncurses-6.2-20210206-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'f87816a803fdbb6403ecb03ea4faec04da8c3a829a1455a2c9e0a0686818ebb6',
     armv7l: 'f87816a803fdbb6403ecb03ea4faec04da8c3a829a1455a2c9e0a0686818ebb6',
       i686: 'ad1fb3a7d832d4fcf4e695cd5f5f7e023581c2d0529a2bf9729acd2cd96e44cd',
     x86_64: 'd81416072e4e4454b585495db8b7e0767867c851e512afd4655fa8174d244c02'
  })

  def self.build
    # build libncursesw
    FileUtils.mkdir 'ncursesw_build'
    Dir.chdir 'ncursesw_build' do
      system "env CFLAGS='-flto=auto' CXXFLAGS='-flto=auto' \
        LDFLAGS='-flto=auto' ../configure \
        #{CREW_OPTIONS} \
        --program-prefix='' \
        --program-suffix='' \
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
         --program-prefix='' \
         --program-suffix='' \
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
