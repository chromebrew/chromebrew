require 'package'

class Ncurses < Package
  description 'The ncurses (new curses) library is a free software emulation of curses in System V Release 4.0 (SVr4), and more. — Wide character'
  homepage 'https://www.gnu.org/software/ncurses/'
  version "6.2-20210403"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/mirror/ncurses.git'
  git_hashtag 'd30f99439fcc8d4bb4c38e5c4afb4f6555fc6ad4'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/ncurses-6.2-20210403-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/ncurses-6.2-20210403-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/ncurses-6.2-20210403-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/ncurses-6.2-20210403-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '4244d294b65d47c744f3991616af8a8c4e01e2620a5e612a94477fd42742b2f8',
     armv7l: '4244d294b65d47c744f3991616af8a8c4e01e2620a5e612a94477fd42742b2f8',
       i686: '27c1aff7631cc628de5f210395015698c8de6ffef287b14e01a06f64a822086b',
     x86_64: 'f356d8d2b2637faf2d16b5f483439bbaca168c7b89ab052c369dcdd62caa6fcd'
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
