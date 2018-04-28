require 'package'

class Ncurses < Package
  description 'The ncurses (new curses) library is a free software emulation of curses in System V Release 4.0 (SVr4), and more.'
  homepage 'https://www.gnu.org/software/ncurses/'
  version '6.1-0'
  source_url 'https://ftpmirror.gnu.org/ncurses/ncurses-6.1.tar.gz'
  source_sha256 'aa057eeeb4a14d470101eff4597d5833dcef5965331be3528c08d99cebaa0d17'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ncurses-6.1-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ncurses-6.1-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ncurses-6.1-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ncurses-6.1-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a12e70f779b2375912a5373b5f320c7b4bef8ddcba5144709e2aed67f8011afe',
     armv7l: 'a12e70f779b2375912a5373b5f320c7b4bef8ddcba5144709e2aed67f8011afe',
       i686: 'a89d5d79d91c8717cfecf7ebbebae6479f8cded2884798643d061605e449c1df',
     x86_64: 'fcaf728604029920a14f27f64f498dfc8a3586bc0426ca6a890adf925e39e204',
  })

  depends_on 'diffutils' => :build

  def self.build
    # build libncursesw
    system "mkdir -p ncursesw_build"
    Dir.chdir("ncursesw_build") do
      system "../configure",
             "--prefix=#{CREW_PREFIX}",
             "--libdir=#{CREW_LIB_PREFIX}",
             "--without-normal",
             "--with-shared",
             "--with-cxx-shared",
             "--without-debug",
             "--enable-pc-files",
             "--with-pkg-config-libdir=#{CREW_LIB_PREFIX}/pkgconfig",
             "--enable-widec"
      system "make"
    end

    # build libncurses
    system "mkdir -p ncurses_build"
    Dir.chdir("ncurses_build") do
      system "../configure",
             "--prefix=#{CREW_PREFIX}",
             "--libdir=#{CREW_LIB_PREFIX}",
             "--without-normal",
             "--with-shared",
             "--with-cxx-shared",
             "--without-debug",
             "--enable-pc-files",
             "--with-pkg-config-libdir=#{CREW_LIB_PREFIX}/pkgconfig",
             "--disable-db-install",
             "--without-manpages",
             "--without-progs",
             "--without-tack"
      system "make"
    end
  end

  def self.install
    Dir.chdir("ncursesw_build") do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
    Dir.chdir("ncurses_build") do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
