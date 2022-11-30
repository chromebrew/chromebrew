require 'package'

class Ncurses < Package
  description 'The ncurses (new curses) library is a free software emulation of curses in System V Release 4.0 (SVr4), and more. — Wide character'
  homepage 'https://www.gnu.org/software/ncurses/'
  version '6.3-20221119'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/mirror/ncurses.git'
  git_hashtag '18c5cff3297b96ac5988a716c66b374734a7de90'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ncurses/6.3-20221119_armv7l/ncurses-6.3-20221119-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ncurses/6.3-20221119_armv7l/ncurses-6.3-20221119-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ncurses/6.3-20221119_i686/ncurses-6.3-20221119-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ncurses/6.3-20221119_x86_64/ncurses-6.3-20221119-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1844aeda65822d900646d847782912b4aed6fe9811a15c9e277aee1b08c9520f',
     armv7l: '1844aeda65822d900646d847782912b4aed6fe9811a15c9e277aee1b08c9520f',
       i686: '3eb7cc37c8f63c6aeb7a46233db1bbc2305a8914670e9f111c0fb3fe2cf5e321',
     x86_64: 'a24d0ce6a592d593e561e921521979bdad3688d1cf606bbaba01a6ceedeacea0'
  })

  depends_on 'gcc' # R
  depends_on 'glibc' # R
  no_patchelf

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
