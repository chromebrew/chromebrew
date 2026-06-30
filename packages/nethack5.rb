require 'buildsystems/cmake'

class Nethack5 < CMake
  description 'NetHack is a \'roguelike\' game following in the same tradition; the player controls an adventurer delving into a randomly generated dungeon to retrieve the Amulet of Yendor from its depths.'
  homepage 'https://github.com/NetHack/NetHack'
  version '5.0.0-64e9cf8'
  license 'nethack'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/mark-z-r/NetHack.git'
  git_hashtag '64e9cf847cf9ffef2dddf454608c1172553c8bb1'
  # source_url 'https://github.com/Nethack/NetHack.git'
  # git_hashtag 'NetHack-5.0'
  # git_hashtag 'dfae1f07dde2c49ea808448af18e8ade6cfe9bf1'
  # git_hashtag "NetHack-#{version}_Released"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '529415a3a9f40bb5c01ef45d0390b1910f554567bee3bdfeaf8d6f90355b31fa',
     armv7l: '529415a3a9f40bb5c01ef45d0390b1910f554567bee3bdfeaf8d6f90355b31fa',
       i686: 'a62bfdd13a4e4cd8ae81b5fd220d86d93a71f455314bb06b53df3ab2d5e7152e',
     x86_64: '1572c4a2585ceb5b6b19876c7e2cf3cc016e1fe9e0a750e855c8668cee66ba9c'
  })

  depends_on 'bdftopcf' => :build
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libx11' => :build
  depends_on 'libxaw' => :build
  depends_on 'libxt' => :build
  depends_on 'lua' => :build
  depends_on 'mkfontscale' => :build
  depends_on 'ncurses' => :executable
  depends_on 'util_linux' => :executable

  no_fhs

  def self.patch
    # patches = [
    #  [
    #    # Cmake support
    #    'https://github.com/NetHack/NetHack/pull/1558.diff',
    #    'de0cc3d4cc3a7ecf385e2507061d56de47447b2118dddea54f31f6396362cdb5'
    #  ]
    # ]
    # ConvenienceFunctions.patch(patches)
    # system 'patch -Np1 -i /output/git/662.diff'
    # system "sed -i 's/NetHack VERSION 3.7/NetHack VERSION 5.0/' CMakeLists.txt"
    # system "sed -i 's/LUA_VERSION 5.4.3/LUA_VERSION 5.4.8/' CMakeLists.txt"
    # system "sed -i 's/SHA512=3a1a3ee8694b72b4ec9d3ce76705fe179328294353604ca950c53f41b41161b449877d43318ef4501fee44ecbd6c83314ce7468d7425ba9b2903c9c32a28bbc0/SHA256=4f18ddae154e793e46eeab727c59ef1c0c0c2b744e7b94219710d76f530629ae/' CMakeLists.txt"
    File.write 'include/nhlua.h', <<~NHLUA_H_EOF
      /* nhlua.h - generated file */
      #include "lua.h"
      #include "lualib.h"
      #include "lauxlib.h"
      /*nhlua.h*/
    NHLUA_H_EOF
  end

  # pre_cmake_options "LDFLAGS='-L#{CREW_LIB_PREFIX}' CFLAGS='-I../include -I#{CREW_PREFIX}/include -I#{CREW_PREFIX}/include/ncursesw -I../include -DNOTPARMDECL -L#{CREW_LIB_PREFIX}'"
  # cmake_options "-DHACKDIR=#{CREW_PREFIX}/var/lib/nethackdir -DCFLAGS='-I../include -I#{CREW_PREFIX}/include -I#{CREW_PREFIX}/include/ncursesw -I../include -DNOTPARMDECL -L#{CREW_LIB_PREFIX}' -DLDFLAGS='-L#{CREW_LIB_PREFIX}'"
  # cmake_options "-DHACKDIR=#{CREW_PREFIX}/var/lib/nethackdir -DCMAKE_C_FLAGS='-I../include -I#{CREW_PREFIX}/include -I#{CREW_PREFIX}/include/ncursesw'"
  # cmake_options "-DCURSES_INCLUDE_PATH=#{CREW_PREFIX}/include/ncursesw -DHACKDIR=#{CREW_PREFIX}/var/lib/nethackdir -DCMAKE_C_FLAGS='-I../include -I#{CREW_PREFIX}/include -I#{CREW_PREFIX}/include/ncursesw'"
  cmake_options "-DCURSES_INCLUDE_PATH=#{CREW_PREFIX}/include/ncursesw -DHACKDIR=#{CREW_PREFIX}/var/lib/nethackdir -DCMAKE_C_FLAGS='-I#{CREW_PREFIX}/include/ncursesw'"
  #  -DCMAKE_C_FLAGS='-I../include -I#{CREW_PREFIX}/include -I#{CREW_PREFIX}/include/ncursesw'"
  # -DCFLAGS='-I../include -I#{CREW_PREFIX}/include -I#{CREW_PREFIX}/include/ncursesw -I../include -DNOTPARMDECL -L#{CREW_LIB_PREFIX}' -DLDFLAGS='-L#{CREW_LIB_PREFIX}'"
  # def self.install
  # system "make DESTDIR=#{CREW_DEST_PREFIX} GIT=1 WANT_WIN_TTY=1 WANT_WIN_CURSES=1 #{'WANT_WIN_X11=1' unless ARCH.include?('i686')} install"
  # end
end
