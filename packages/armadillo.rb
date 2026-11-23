require 'buildsystems/cmake'

class Armadillo < CMake
  description 'Armadillo is a high quality linear algebra library (matrix maths) for the C++ language, aiming towards a good balance between speed and ease of use'
  homepage 'https://arma.sourceforge.net/'
  version '15.8.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/arma/armadillo-#{version}.tar.xz"
  source_sha256 '84cba6695fa523a7bf9d46bd20d000c4d4f108fbdc15ba45c294d507f5def880'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9aa73df2d33c999258b2398c5cc5b16e4def388ee28466c031c750a156a958e3',
     armv7l: '9aa73df2d33c999258b2398c5cc5b16e4def388ee28466c031c750a156a958e3',
       i686: 'e50f297ddc684dfdcecaf0e93079d3790925d9d266dfe7f2c39d370d5f36ce43',
     x86_64: 'd085cca6d2ce2ba21b42049928af6a0f0a7098fe5b63b7f82938a7b7e93e0c43'
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
