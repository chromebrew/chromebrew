require 'buildsystems/cmake'

class Multitail < CMake
  description 'MultiTail allows you to monitor logfiles and command output in multiple windows in a terminal, colorize, filter and merge.'
  homepage 'https://www.vanheusden.com/multitail/'
  version '7.1.6'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/folkertvanheusden/multitail.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6ed35ce94a07dc37dad01ee31ad6ee172741f31a650244751a835f04cc15c1f3',
     armv7l: '6ed35ce94a07dc37dad01ee31ad6ee172741f31a650244751a835f04cc15c1f3',
       i686: '4cd54e1deef581f9f8b2a2550bd01a363dc8be13b67c5af194efe233eb4c43d6',
     x86_64: '07cee2620d98a4f32370059ad786c2a7540b2ee9bf4a2bdcf238bc976ebd754d'
  })

  depends_on 'glibc' => :executable
  depends_on 'ncurses' => :executable

  cmake_options "-DCMAKE_C_FLAGS='-I#{CREW_PREFIX}/include/ncursesw'"
end
