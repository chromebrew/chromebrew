require 'buildsystems/cmake'

class Multitail < CMake
  description 'MultiTail allows you to monitor logfiles and command output in multiple windows in a terminal, colorize, filter and merge.'
  homepage 'https://www.vanheusden.com/multitail/'
  version '7.1.5'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/folkertvanheusden/multitail.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0e9d7d2bdb9f328d92e366c5d908e8fdb94c12cd8aeb0331fa7921595ce6321e',
     armv7l: '0e9d7d2bdb9f328d92e366c5d908e8fdb94c12cd8aeb0331fa7921595ce6321e',
       i686: '72d384d94f5dc87c27e9afa704e7343b02618573413522a39f04527c4fd359bb',
     x86_64: 'eb31ec5a22057605bfc74da263eb0bff38c84f20b73e9d1092fc3c2b420bf781'
  })

  depends_on 'glibc' => :executable_only
  depends_on 'ncurses' => :executable_only

  cmake_options "-DCMAKE_C_FLAGS='-I#{CREW_PREFIX}/include/ncursesw'"
end
