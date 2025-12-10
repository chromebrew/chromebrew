require 'buildsystems/cmake'

class Armadillo < CMake
  description 'Armadillo is a high quality linear algebra library (matrix maths) for the C++ language, aiming towards a good balance between speed and ease of use'
  homepage 'https://arma.sourceforge.net/'
  version '15.2.2'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://gitlab.com/conradsnicta/armadillo-code.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fdaf0af8d741453f0399f5937d3e13176ebfb738a009b74452f29884cafab34d',
     armv7l: 'fdaf0af8d741453f0399f5937d3e13176ebfb738a009b74452f29884cafab34d',
       i686: '4bdcf0ecc8e9b0fcff45727bd6dcfddc3d841426dad627c5d7ee5812bdcfc57c',
     x86_64: 'dd6a4767206b81c0754cb5335c521392d87bb238cad610cf77e5f3353be949a0'
  })

  depends_on 'arpack_ng' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'hdf5' => :build
  depends_on 'lapack' # R
  depends_on 'openblas' # R
  depends_on 'superlu' # R

  cmake_options "-DARPACK_LIBRARY=#{CREW_LIB_PREFIX}/libarpack#{'64' if ARCH == 'x86_64'}.so"
end
