require 'package'

class Ncurses < Package
  description 'The ncurses (new curses) library is a free software emulation of curses in System V Release 4.0 (SVr4), and more. — Wide character'
  homepage 'https://www.gnu.org/software/ncurses/'
  version '6.3-20211106'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/mirror/ncurses.git'
  git_hashtag 'f399f54c6c4ea2143afcbf704ce9af0be52b63fc'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ncurses/6.3-20211106_armv7l/ncurses-6.3-20211106-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ncurses/6.3-20211106_armv7l/ncurses-6.3-20211106-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ncurses/6.3-20211106_i686/ncurses-6.3-20211106-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ncurses/6.3-20211106_x86_64/ncurses-6.3-20211106-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'ca5672be1713a202243f5c13bbb688254cf0c93b075dcfc5c3d51677d6861b1e',
     armv7l: 'ca5672be1713a202243f5c13bbb688254cf0c93b075dcfc5c3d51677d6861b1e',
       i686: '208930e9bb95aa70c7111e3ea22fcdc4f03295153feed0b7b2b79ff179a42d13',
     x86_64: '567cf7a40682009b0b817795e62e248374e87896ab76e5bd5fc69f98d252bf31'
  })

  no_patchelf

  def self.build
    # build libncurses
    Dir.mkdir 'ncurses_build'
    Dir.chdir 'ncurses_build' do
      # system "env #{CREW_ENV_OPTIONS} \
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
      # system "env #{CREW_ENV_OPTIONS} \
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
    # Make symlinks for non-wide software
    # Dir.chdir CREW_DEST_LIB_PREFIX.to_s do
    #  Dir.glob('*w.so*').each do |f|
    #    @basefile_nowide = f.gsub('w.so', '.so')
    #    puts "Symlinking #{f} to #{@basefile_nowide}"
    #    FileUtils.ln_sf f, @basefile_nowide
    #  end
    # end
  end
end
