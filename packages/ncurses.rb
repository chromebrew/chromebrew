require 'package'

class Ncurses < Package
  description 'The ncurses (new curses) library is a free software emulation of curses in System V Release 4.0 (SVr4), and more. — Wide character'
  homepage 'https://www.gnu.org/software/ncurses/'
  version '6.4-20230909'
  license 'MIT'
  compatibility 'all'
  source_url 'https://invisible-island.net/archives/ncurses/current/ncurses-6.4-20230909.tgz'
  source_sha256 'f859a4646974231a099a9339bbd66146dd4746a0dcbb802913c73335f8c750bb'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ncurses/6.4-20230909_armv7l/ncurses-6.4-20230909-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ncurses/6.4-20230909_armv7l/ncurses-6.4-20230909-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ncurses/6.4-20230909_i686/ncurses-6.4-20230909-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ncurses/6.4-20230909_x86_64/ncurses-6.4-20230909-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '5698eaefd29e5e1526baef7f8eb84d2c1a8e286df43b9b17d659eb8edc65b0e6',
     armv7l: '5698eaefd29e5e1526baef7f8eb84d2c1a8e286df43b9b17d659eb8edc65b0e6',
       i686: 'e5210cbf69eb819c659106ce34196df8a287fdbec55bdb2f6b4d4a4b402408d3',
     x86_64: 'abe7e5d619073319c8e5f8963f6b64619a64a0e3c6cdf5eb9ee79776a1d21283'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.build
    # build libncurses
    Dir.mkdir 'ncurses_build'
    Dir.chdir 'ncurses_build' do
      system "../configure #{CREW_OPTIONS} \
          --program-prefix='' \
          --program-suffix='' \
          --with-shared \
          --with-cxx-shared \
          --without-debug \
          --enable-pc-files \
          --with-pkg-config-libdir=#{CREW_LIB_PREFIX}/pkgconfig \
          --disable-widec \
          --without-tests \
          --with-termlib \
          --enable-termcap"
      system 'make'
    end
    # build libncursesw
    Dir.mkdir 'ncursesw_build'
    Dir.chdir 'ncursesw_build' do
      system "../configure #{CREW_OPTIONS} \
          --program-prefix='' \
          --program-suffix='' \
          --with-shared \
          --with-cxx-shared \
          --without-debug \
          --enable-pc-files \
          --with-pkg-config-libdir=#{CREW_LIB_PREFIX}/pkgconfig \
          --enable-widec \
          --without-tests \
          --with-termlib \
          --enable-termcap"
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'ncurses_build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
    Dir.chdir 'ncursesw_build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
    # Remove conflicts with dvtm package.
    Dir.chdir "#{CREW_DEST_PREFIX}/share/terminfo/d" do
      FileUtils.rm %w[dvtm dvtm-256color]
    end
  end
end
