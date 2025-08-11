require 'buildsystems/cmake'

class Armadillo < CMake
  description 'Armadillo is a high quality linear algebra library (matrix maths) for the C++ language, aiming towards a good balance between speed and ease of use'
  homepage 'https://arma.sourceforge.net/'
  version '14.6.2'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://gitlab.com/conradsnicta/armadillo-code.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cabc00c9184da1185c0fcbe834c1447e0e31a9ff34b9c2ede39f7419b95768cc',
     armv7l: 'cabc00c9184da1185c0fcbe834c1447e0e31a9ff34b9c2ede39f7419b95768cc',
       i686: 'cead7ef29533291a9070b8b1cddf6d909c224463e0e984a4d5bf49a208f17590',
     x86_64: '313502ef0f2c9c701c4e5c59d456a6105c8aba4c63bc0a77a829649ffa2e9e78'
  })

  depends_on 'arpack_ng'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R  depends_on 'hdf5'
  depends_on 'lapack' # R
  depends_on 'openblas' # R  depends_on 'superlu'

  cmake_options "-DARPACK_LIBRARY=#{CREW_LIB_PREFIX}/libarpack#{'64' if ARCH == 'x86_64'}.so"
end
