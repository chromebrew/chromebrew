require 'buildsystems/cmake'

class Swi_prolog < CMake
  description 'SWI-Prolog offers a comprehensive free Prolog environment.'
  homepage 'https://www.swi-prolog.org'
  version '10.1.5'
  license 'BSD-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/SWI-Prolog/swipl-devel.git'
  git_hashtag "V#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c6045d6ad6e8e4f21e30ec4e937dfbcdff93dee67de1c297ca251e58bba52c21',
     armv7l: 'c6045d6ad6e8e4f21e30ec4e937dfbcdff93dee67de1c297ca251e58bba52c21',
     x86_64: '86cf759a7fbb1ffcc2c625b97efbf7e1c8ce0c2946b04ed324412b5bea85290f'
  })

  depends_on 'cairo' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gmp' => :library
  depends_on 'harfbuzz' => :library
  depends_on 'libarchive' => :library
  depends_on 'libdb' => :library
  depends_on 'libedit' => :library
  depends_on 'libxcrypt' => :library
  depends_on 'libyaml' => :library
  depends_on 'ncurses' => :library
  depends_on 'openjdk17' => :executable
  depends_on 'openssl' => :library
  depends_on 'pango' => :library
  depends_on 'pcre2' => :library
  depends_on 'python3' => :library
  depends_on 'readline' => :library
  depends_on 'sdl3' => :library
  depends_on 'sdl3_image' => :library
  depends_on 'termcap' => :library
  depends_on 'zlib' => :library

  def self.patch
    # Fix error: implicit declaration of function ‘va_start’.
    system "sed -i '35i#include <stdarg.h>' packages/libedit/libedit/src/terminal.c"
  end

  pre_cmake_options "CFLAGS+=' -I#{CREW_PREFIX}/include/ncurses'"
  cmake_options '-DCMAKE_BUILD_TYPE=PGO'
end
