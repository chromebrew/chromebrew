require 'buildsystems/cmake'

class Armadillo < CMake
  description 'Armadillo is a high quality linear algebra library (matrix maths) for the C++ language, aiming towards a good balance between speed and ease of use'
  homepage 'https://arma.sourceforge.net/'
  version '15.4.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/arma/armadillo-#{version}.tar.xz"
  source_sha256 'f781e9d935db7e8b9a64c58b6a817354d38a1769e179b477364f5e6414953f6c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '949bea3003e042b153a6869e5b8fe3ad8976c5ca68a3ce8d588b54cd8e89a07b',
     armv7l: '949bea3003e042b153a6869e5b8fe3ad8976c5ca68a3ce8d588b54cd8e89a07b',
       i686: '12a3845f6387e9404c1ff3970a6fbce12c73e37e2f07f49791adaec1399bd841',
     x86_64: '37004073a7bf627e524e6135f865ab1068d259cffd29b92f57aab585c9ec33d2'
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
