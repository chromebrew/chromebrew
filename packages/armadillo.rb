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
    aarch64: '6a9e9bbff7ace5b3a4cf7975743041e31284df23e20d2145fdbb767d468c0a73',
     armv7l: '6a9e9bbff7ace5b3a4cf7975743041e31284df23e20d2145fdbb767d468c0a73',
       i686: '0331ff694e26eb871af66dd64cd4b2f20250f91b43b19180211045d44205dbf3',
     x86_64: '8ba5b57f22e4caea2d246458e3ccea1b4255169694d1aef67c607c3c6052e64b'
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
