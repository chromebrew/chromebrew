require 'package'

class Ncurses < Package
  description 'The ncurses (new curses) library is a free software emulation of curses in System V Release 4.0 (SVr4), and more. — Wide character'
  homepage 'https://www.gnu.org/software/ncurses/'
  @_ver = 6.2
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/ncurses/ncurses-#{@_ver}.tar.gz"
  source_sha256 '30306e0c76e0f9f1f0de987cf1c82a5c21e1ce6568b9227f7da5b71cbea86c9d'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/ncurses-6.2-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/ncurses-6.2-1-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/ncurses-6.2-1-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/ncurses-6.2-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '8f07ad615e960adea4a458cde9b4129bc6b3bf387a4d410f7c343e73cebdde32',
     armv7l: '8f07ad615e960adea4a458cde9b4129bc6b3bf387a4d410f7c343e73cebdde32',
       i686: '704f171007a30c8db3e4ac6ffba11b5f2ad69a388f8cf2b0726f2e2178c809bb',
     x86_64: '508ebaa8dad47d2eb84e499c7d86f96227dbe556e32f71f0cb6744903acf9d6d'
  })

  def self.build
    # build libncursesw
    FileUtils.mkdir 'ncursesw_build'
    Dir.chdir 'ncursesw_build' do
      system "env #{CREW_ENV_OPTIONS} \
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
    # Make symlinks for non-wide software
    Dir.chdir CREW_DEST_LIB_PREFIX.to_s do
      Dir.glob('*w.so*').each do |f|
        @basefile_nowide = f.gsub('w.so', '.so')
        puts "Symlinking #{f} to #{@basefile_nowide}"
        FileUtils.ln_sf f, @basefile_nowide
      end
    end
  end
end
