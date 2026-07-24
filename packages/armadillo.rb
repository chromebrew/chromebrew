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
    aarch64: 'd56f75f7bcc89a5e051570249514bf63b3ac2a9604dc4500e46573e8096e5c32',
     armv7l: 'd56f75f7bcc89a5e051570249514bf63b3ac2a9604dc4500e46573e8096e5c32',
       i686: '43c234af0fb117d5ecf25a213b225062861d51d7cfb18c8a93a6ebf11fe1d4fc',
     x86_64: 'c69ed0cd333193c48144cc225e1f922b5556d4608fd1608e3aafcfc56722afc1'
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
