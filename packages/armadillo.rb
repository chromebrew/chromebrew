require 'buildsystems/cmake'

class Armadillo < CMake
  description 'Armadillo is a high quality linear algebra library (matrix maths) for the C++ language, aiming towards a good balance between speed and ease of use'
  homepage 'https://arma.sourceforge.net/'
  version '15.2.7'
  license 'Apache-2.0'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/arma/armadillo-#{version}.tar.xz"
  source_sha256 '029230b29c3745924ea850c7046efd1db74b863fdfead8b1aaba3bdd5b0cf895'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a6f77a5f615f22937d736f0957919dbd5758f9b40e6a72529dfae5830fddc1ee',
     armv7l: 'a6f77a5f615f22937d736f0957919dbd5758f9b40e6a72529dfae5830fddc1ee',
       i686: '425bb8096dc4bf6a2b8357f05237edaf70eb23033e45a42894bee61d6720410c',
     x86_64: '78100c9da1edfc2149aac3e3316e8af1882cb03e88ca552d95aca1e751eaeade'
  })

  depends_on 'arpack_ng' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'hdf5' => :build
  depends_on 'lapack' => :library
  depends_on 'openblas' => :library
  depends_on 'superlu' => :library

  cmake_options "-DARPACK_LIBRARY=#{CREW_LIB_PREFIX}/libarpack#{'64' if ARCH == 'x86_64'}.so"
end
