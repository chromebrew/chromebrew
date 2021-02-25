require 'package'

class Ncurses < Package
  description 'The ncurses (new curses) library is a free software emulation of curses in System V Release 4.0 (SVr4), and more.'
  homepage 'https://www.gnu.org/software/ncurses/'
  version '6.2-20210220'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/ncurses/ncurses-6.2.tar.gz'
  source_sha256 '30306e0c76e0f9f1f0de987cf1c82a5c21e1ce6568b9227f7da5b71cbea86c9d'
  
  depends_on 'ncursesw'

  def self.build
    system "./configure #{CREW_OPTIONS} \
              --with-build-cflags='-flto=auto' \
              --with-build-cxxflags='-flto=auto' \
              --with-build-ldflags='-flto=auto' \
              --with-curses-h \
              --program-prefix='' \
              --program-suffix='' \
              --with-shared \
              --with-normal \
              --with-cxx-shared \
              --without-debug \
              --enable-pc-files \
              --with-pkg-config-libdir=#{CREW_LIB_PREFIX}/pkgconfig \
              --disable-db-install \
              --without-manpages \
              --without-progs \
              --without-tack \
              --with-termlib"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    # See https://forums.opensuse.org/showthread.php/446927-missing-library-libtinfo-so-5.
    # See also http://www.linuxforums.org/forum/installation/6251-libtinfo-so-5-a.html.
    Dir.chdir CREW_DEST_LIB_PREFIX do
      FileUtils.ln_s "libtinfo.so.6", "libtinfo.so.5"
    end
  end
  
  def self.check
    system 'make', 'check'
  end
end
