require 'package'

class Ncursesw < Package
  description 'The ncurses (new curses) library is a free software emulation of curses in System V Release 4.0 (SVr4), and more. — Wide character'
  homepage 'https://www.gnu.org/software/ncurses/'
  version '6.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/ncurses/ncurses-6.2.tar.gz'
  source_sha256 '30306e0c76e0f9f1f0de987cf1c82a5c21e1ce6568b9227f7da5b71cbea86c9d'

  binary_url ({
  x86_64: 'https://github.com/chromebrew/binaries/raw/master/n/ncursesw/6.2/ncursesw-6.2-chromeos-x86_64.tar.xz'
  })
binary_sha256 ({
  x86_64 '119e8fa43785c6791d3cc969fbbfe23b0a4bc5c3d84e9313292638a9a11f60d8'
  })

  def self.build
    # build libncursesw
    FileUtils.mkdir 'ncursesw_build'
    Dir.chdir 'ncursesw_build' do
      system "env CFLAGS='-flto=auto' \
          CXXFLAGS='-flto=auto' \
          LDFLAGS='-flto=auto' \
        ../configure #{CREW_OPTIONS} \
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
  end

  def self.install
    Dir.chdir 'ncursesw_build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
