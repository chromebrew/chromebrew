require 'buildsystems/cmake'

class Nethack5 < CMake
  description 'NetHack is a \'roguelike\' game following in the same tradition; the player controls an adventurer delving into a randomly generated dungeon to retrieve the Amulet of Yendor from its depths.'
  homepage 'https://github.com/NetHack/NetHack'
  version '5.0.0'
  license 'nethack'
  compatibility 'all'
  source_url 'https://github.com/satmandu/NetHack.git'
  git_hashtag 'NetHack-5.0'
  # git_hashtag 'dfae1f07dde2c49ea808448af18e8ade6cfe9bf1'
  # git_hashtag "NetHack-#{version}_Released"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '529415a3a9f40bb5c01ef45d0390b1910f554567bee3bdfeaf8d6f90355b31fa',
     armv7l: '529415a3a9f40bb5c01ef45d0390b1910f554567bee3bdfeaf8d6f90355b31fa',
       i686: 'a62bfdd13a4e4cd8ae81b5fd220d86d93a71f455314bb06b53df3ab2d5e7152e',
     x86_64: '1572c4a2585ceb5b6b19876c7e2cf3cc016e1fe9e0a750e855c8668cee66ba9c'
  })

  unless ARCH.include?('i686')
    depends_on 'bdftopcf' => :build
    depends_on 'libx11' => :build
    depends_on 'libxaw' => :build
    depends_on 'libxt' => :build
    depends_on 'mkfontscale' => :build
    depends_on 'glibc' => :executable
    depends_on 'ncurses' => :executable
    depends_on 'util_linux' => :executable
  end

  no_env_options
  no_fhs
  no_lto

  def self.patch
    # system "sed -i 's,CCFLAGS = -g,CCFLAGS = -g -I../include -I#{CREW_PREFIX}/include -I#{CREW_PREFIX}/include/ncursesw -L#{CREW_LIB_PREFIX},' sys/unix/hints/include/compiler.500"
    # system "sed 's,/usr,#{CREW_PREFIX},g' sys/unix/hints/linux.500 > sys/unix/hints/chromebrew.500"
    # system "sed -i 's,PREFIX=$(wildcard ~)/nh/install,PREFIX=#{CREW_PREFIX},' sys/unix/hints/chromebrew.500"
    # system "sed -i 's,$(PREFIX)/games,$(PREFIX)/var,' sys/unix/hints/chromebrew.500"
    # system "sed -i 's,INSTDIR=$(HACKDIR),INSTDIR=$(DESTDIR),' sys/unix/hints/chromebrew.500"
    # system "sed -i 's,HACKDIR=$(PREFIX)/games/lib/nethackdir,HACKDIR=$(PREFIX)/var/lib/nethackdir,' sys/unix/hints/chromebrew.500"
    # system './setup.sh hints/chromebrew.500', chdir: 'sys/unix'
    # system "make  GIT=1 WANT_WIN_TTY=1 WANT_WIN_CURSES=1 #{'WANT_WIN_X11=1' unless ARCH.include?('i686')}"
    # patches = [
    # [
    # #Cmake support for 3.7.
    # 'https://github.com/NetHack/NetHack/pull/662.diff',
    # '770af44efa1c0d62637bdabd88e9ba2771aaf8bbc8a8cefda733172252f7d2d0'
    # ],
    # [
    ## Cmake fixup
    # 'https://github.com/Flone-dnb/NetHack/commit/3d264fe49dc6e2e0ee0374aebaa95abfdf62a733.diff',
    # '533456ef3a2dfa9ae9315686d5744be5e77a2e4c594e7f335a3179905e137d38'
    # ]
    # ]
    # ConvenienceFunctions.patch(patches)
    # system 'patch -Np1 -i /output/git/662.diff'
    # system "sed -i 's/NetHack VERSION 3.7/NetHack VERSION 5.0/' CMakeLists.txt"
    # system "sed -i 's/LUA_VERSION 5.4.3/LUA_VERSION 5.4.8/' CMakeLists.txt"
    # system "sed -i 's/SHA512=3a1a3ee8694b72b4ec9d3ce76705fe179328294353604ca950c53f41b41161b449877d43318ef4501fee44ecbd6c83314ce7468d7425ba9b2903c9c32a28bbc0/SHA256=4f18ddae154e793e46eeab727c59ef1c0c0c2b744e7b94219710d76f530629ae/' CMakeLists.txt"
  end

  # cmake_options "-DHACKDIR=#{CREW_PREFIX}/var/lib/nethackdir -DCFLAGS='-I../include -I#{CREW_PREFIX}/include -I#{CREW_PREFIX}/include/ncursesw -I../include -DNOTPARMDECL -L#{CREW_LIB_PREFIX}' -DLDFLAGS='-L#{CREW_LIB_PREFIX}'"
  # pre_cmake_options "LDFLAGS='-L#{CREW_LIB_PREFIX}' CFLAGS='-I../include -I#{CREW_PREFIX}/include -I#{CREW_PREFIX}/include/ncursesw -I../include -DNOTPARMDECL -L#{CREW_LIB_PREFIX}'"
  # cmake_options "-DHACKDIR=#{CREW_PREFIX}/var/lib/nethackdir -DCFLAGS='-I../include -I#{CREW_PREFIX}/include -I#{CREW_PREFIX}/include/ncursesw -I../include -DNOTPARMDECL -L#{CREW_LIB_PREFIX}' -DLDFLAGS='-L#{CREW_LIB_PREFIX}'"
  cmake_options "-DHACKDIR=#{CREW_PREFIX}/var/lib/nethackdir -DCMAKE_C_FLAGS='-I../include -I#{CREW_PREFIX}/include -I#{CREW_PREFIX}/include/ncursesw'"
  # -DCFLAGS='-I../include -I#{CREW_PREFIX}/include -I#{CREW_PREFIX}/include/ncursesw -I../include -DNOTPARMDECL -L#{CREW_LIB_PREFIX}' -DLDFLAGS='-L#{CREW_LIB_PREFIX}'"
  # def self.install
  # system "make DESTDIR=#{CREW_DEST_PREFIX} GIT=1 WANT_WIN_TTY=1 WANT_WIN_CURSES=1 #{'WANT_WIN_X11=1' unless ARCH.include?('i686')} install"
  # end
end
