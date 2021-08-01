require 'package'

class Ncurses < Package
  description 'The ncurses (new curses) library is a free software emulation of curses in System V Release 4.0 (SVr4), and more. — Wide character'
  homepage 'https://www.gnu.org/software/ncurses/'
  version "6.2-20210523"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/mirror/ncurses.git'
  git_hashtag '2a969388725aa1ee321acadf09a4ff8e00787036'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ncurses/6.2-20210523_armv7l/ncurses-6.2-20210523-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ncurses/6.2-20210523_armv7l/ncurses-6.2-20210523-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ncurses/6.2-20210523_i686/ncurses-6.2-20210523-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ncurses/6.2-20210523_x86_64/ncurses-6.2-20210523-chromeos-x86_64.tpxz',
  })
  binary_sha256({
    aarch64: '3538b4549d28f6feaef14a7af2137583dad694d2cb037100851011212cf68b11',
     armv7l: '3538b4549d28f6feaef14a7af2137583dad694d2cb037100851011212cf68b11',
       i686: 'f9aca213186c41baef27756accf932fd7da84db8b0a159f7a1163da5258e0c35',
     x86_64: '15e5fc746918148febf15f417ffd5012e073a43d7011e7474cb0819b4492e096',
  })

  def self.build
    # build libncurses
    Dir.mkdir 'ncurses_build'
    Dir.chdir 'ncurses_build' do
      #system "env #{CREW_ENV_OPTIONS} \
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
      #system "env #{CREW_ENV_OPTIONS} \
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
    #Dir.chdir CREW_DEST_LIB_PREFIX.to_s do
    #  Dir.glob('*w.so*').each do |f|
    #    @basefile_nowide = f.gsub('w.so', '.so')
    #    puts "Symlinking #{f} to #{@basefile_nowide}"
    #    FileUtils.ln_sf f, @basefile_nowide
    #  end
    #end
  end
end
