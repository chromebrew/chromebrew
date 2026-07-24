require 'buildsystems/cmake'

class Armadillo < CMake
  description 'Armadillo is a high quality linear algebra library (matrix maths) for the C++ language, aiming towards a good balance between speed and ease of use'
  homepage 'https://arma.sourceforge.net/'
  version '15.4.2'
  license 'Apache-2.0'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/arma/armadillo-#{version}.tar.xz"
  source_sha256 '58fa258d0e1f93074c9afa792027fc259b85cb974ccc0b932b061d4ada5bd83a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1eaa279583413278f7536bd67caa1e3c8dd11960441eb4ae10ec99040f86fed2',
     armv7l: '1eaa279583413278f7536bd67caa1e3c8dd11960441eb4ae10ec99040f86fed2',
       i686: 'a044810ec2d81c58b2460d1d1e5a93db41087e456f5ea35022dbc7c2f7d2d423',
     x86_64: 'cb393bf777adb36fe489c293ce89dd4cac4effa03512ada72d48f602b0a7460a'
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
