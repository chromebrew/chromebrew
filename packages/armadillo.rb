require 'buildsystems/cmake'

class Armadillo < CMake
  description 'Armadillo is a high quality linear algebra library (matrix maths) for the C++ language, aiming towards a good balance between speed and ease of use'
  homepage 'https://arma.sourceforge.net/'
  version '15.2.4'
  license 'Apache-2.0'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/arma/armadillo-#{version}.tar.xz"
  source_sha256 'bb03a16da6b2cca43962b65a2890faf4e6b16607220cf60270436a11e09e6f46'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a76ab2c3eeff2dfff44a1d24c84e8de2f53f0004dba346f6ad8c7073d1e650ec',
     armv7l: 'a76ab2c3eeff2dfff44a1d24c84e8de2f53f0004dba346f6ad8c7073d1e650ec',
       i686: '21313805a60f3b2779bf295371b4ac0425080685e15a9bb91d11feb173213e79',
     x86_64: 'faa27289ad2d7c657e8446cebb0136004d1f814a05d674eeeeabc96e04c9c75e'
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
