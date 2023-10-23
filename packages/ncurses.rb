require 'package'

class Ncurses < Package
  description 'The ncurses (new curses) library is a free software emulation of curses in System V Release 4.0 (SVr4), and more. — Wide character'
  homepage 'https://www.gnu.org/software/ncurses/'
  version 'v6_4_20231021'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ThomasDickey/ncurses-snapshots.git'
  git_hashtag 'v6_4_20231021'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ncurses/v6_4_20231021_armv7l/ncurses-v6_4_20231021-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ncurses/v6_4_20231021_armv7l/ncurses-v6_4_20231021-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ncurses/v6_4_20231021_i686/ncurses-v6_4_20231021-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ncurses/v6_4_20231021_x86_64/ncurses-v6_4_20231021-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4ce9f40fed6fcc727a0fb4e8d107794a4cd4149ec3f6e779ef42fe9ca6e8a801',
     armv7l: '4ce9f40fed6fcc727a0fb4e8d107794a4cd4149ec3f6e779ef42fe9ca6e8a801',
       i686: '2e2d67bdd306f40862f5fff598ba0f53dda905925afefe8e9ca8d9b1222c3b22',
     x86_64: '7394f2b9be9892b60f8bff64cd311844c2f9bcae188c8a6c7534c70d85da1743'
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
