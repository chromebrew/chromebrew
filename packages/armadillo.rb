require 'buildsystems/cmake'

class Armadillo < CMake
  description 'Armadillo is a high quality linear algebra library (matrix maths) for the C++ language, aiming towards a good balance between speed and ease of use'
  homepage 'https://arma.sourceforge.net/'
  version '15.6.2'
  license 'Apache-2.0'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/arma/armadillo-#{version}.tar.xz"
  source_sha256 '63ee9351b54994dff7b4e2094a86ace48cfb41354cb65893a9dab7c8a16382c4'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9b84f850fa472d2b36a8f81e32ea78255f7e49c5c20a55c4fd40543892128afc',
     armv7l: '9b84f850fa472d2b36a8f81e32ea78255f7e49c5c20a55c4fd40543892128afc',
       i686: 'cee0cffb53f48aef7989f7bb51530e7ae2db90bba35eb13c053373e98aee82d0',
     x86_64: '59a9bbd1b9e75333b5bd19ae1ca61fee59e9caf5533a49a2f0030d8e2798cf8e'
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
