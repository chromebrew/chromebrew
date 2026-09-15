require 'buildsystems/cmake'

class Suitesparse < CMake
  description 'A suite of sparse matrix software'
  homepage 'https://people.engr.tamu.edu/davis/suitesparse.html'
  version '7.14.1'
  license 'metapackage'
  compatibility 'all'
  source_url 'https://github.com/DrTimothyAldenDavis/SuiteSparse.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '88de046e349d6ad27290b6f38061ed689bb3e6a6270e1bb73acb6858c48eb6fb',
     armv7l: '88de046e349d6ad27290b6f38061ed689bb3e6a6270e1bb73acb6858c48eb6fb',
       i686: '6dbc59ec344d12e7551ddfcb91124dc4f8ff029e3ccc112d85e098eac7e87167',
     x86_64: 'c5095f5273a4371d763efb46da03fd2a4a2ad887a33da5eb90ad52932b45075c'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gmp' => :library
  depends_on 'lapack' => :build
  depends_on 'mpfr' => :library
  depends_on 'openblas' => :library
end
