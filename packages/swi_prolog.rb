require 'buildsystems/cmake'

class Swi_prolog < CMake
  description 'SWI-Prolog offers a comprehensive free Prolog environment.'
  homepage 'https://www.swi-prolog.org'
  version '9.3.5'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/SWI-Prolog/swipl-devel.git'
  git_hashtag "V#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c6045d6ad6e8e4f21e30ec4e937dfbcdff93dee67de1c297ca251e58bba52c21',
     armv7l: 'c6045d6ad6e8e4f21e30ec4e937dfbcdff93dee67de1c297ca251e58bba52c21',
       i686: 'c87d2ad03d051055420b8c5b65f0d6b26b93e933b1095a77e16928332f6f1d76',
     x86_64: '86cf759a7fbb1ffcc2c625b97efbf7e1c8ce0c2946b04ed324412b5bea85290f'
  })

  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'libarchive'
  depends_on 'libdb'
  depends_on 'libedit' # R
  depends_on 'libyaml'
  depends_on 'openssl' # R
  depends_on 'pcre2' # R
  depends_on 'python3' # R
  depends_on 'readline' # R
  depends_on 'zlibpkg' # R

  pre_cmake_options "CFLAGS+=' -I#{CREW_PREFIX}/include/ncurses'"
  cmake_options '-DCMAKE_BUILD_TYPE=PGO'
end
