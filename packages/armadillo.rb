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
    aarch64: '6a768bdcf1deea0482165ae54bab0095b95d71be1efcdad3227160cae6abf269',
     armv7l: '6a768bdcf1deea0482165ae54bab0095b95d71be1efcdad3227160cae6abf269',
       i686: '99f4163e5a8274c129a45359709e4f4696a8a1f6462d68121118dff8e84277bd',
     x86_64: '3e63feaa2fd2e0319ca7b7bfe8fe242ccfe626fc22a47468e7edd2af8735dda4'
  })

  depends_on 'arpack_ng'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R  depends_on 'hdf5'
  depends_on 'lapack' # R
  depends_on 'openblas' # R  depends_on 'superlu'

  cmake_options "-DARPACK_LIBRARY=#{CREW_LIB_PREFIX}/libarpack#{'64' if ARCH == 'x86_64'}.so"
end
