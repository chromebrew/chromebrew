require 'buildsystems/cmake'

class Armadillo < CMake
  description 'Armadillo is a high quality linear algebra library (matrix maths) for the C++ language, aiming towards a good balance between speed and ease of use'
  homepage 'https://arma.sourceforge.net/'
  version '15.2.3'
  license 'Apache-2.0'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/arma/armadillo-#{version}.tar.xz"
  source_sha256 '0182d67d6949e4347a0bc62fc8c2793be7eb203c71f19edff93f8c45fd4a8190'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '28c7d54f2f07ccd57d9ce4f66ead102975f92c42a7057585f232fc2358141e1b',
     armv7l: '28c7d54f2f07ccd57d9ce4f66ead102975f92c42a7057585f232fc2358141e1b',
       i686: '63496149d5087eded9ffa5afcad7d3650c7bd224bce7c5423d5a75a79f605bcd',
     x86_64: '248f40bc0b3dd20c9fcf0f0d5e0f212c70536ccdb6225a504dfae41650959b01'
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
