require 'buildsystems/cmake'

class Armadillo < CMake
  description 'Armadillo is a high quality linear algebra library (matrix maths) for the C++ language, aiming towards a good balance between speed and ease of use'
  homepage 'https://arma.sourceforge.net/'
  version '15.2.6'
  license 'Apache-2.0'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/arma/armadillo-#{version}.tar.xz"
  source_sha256 '97cb8ef708541f632e861d005a462dd0367240f81ff96f8e63ebbdd75c8ce55f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '444ca1886e731fa73a06db61507b5dde5a67baea20e5fecf821131c7fe3c1148',
     armv7l: '444ca1886e731fa73a06db61507b5dde5a67baea20e5fecf821131c7fe3c1148',
       i686: 'd7e3ff2255c516ed8d0583985053bc7247ae2a3ebe21189c54891835a2205d18',
     x86_64: 'da9733b53288014dbd0ad1c0f873a891186b58d3655b81cf7af47ac1257496ab'
  })

  depends_on 'arpack_ng' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'hdf5' => :build
  depends_on 'lapack' => :library
  depends_on 'openblas' => :library
  depends_on 'superlu' => :library

  cmake_options "-DARPACK_LIBRARY=#{CREW_LIB_PREFIX}/libarpack#{'64' if ARCH == 'x86_64'}.so"
end
