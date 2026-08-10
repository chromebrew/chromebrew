require 'buildsystems/cmake'

class Suitesparse < CMake
  description 'A suite of sparse matrix software'
  homepage 'https://people.engr.tamu.edu/davis/suitesparse.html'
  version '7.12.3'
  license 'metapackage'
  compatibility 'all'
  source_url 'https://github.com/DrTimothyAldenDavis/SuiteSparse.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0ead52eaaa446ba93455588133ddda2eac111cc6fb72a105dc8b972ea873de8b',
     armv7l: '0ead52eaaa446ba93455588133ddda2eac111cc6fb72a105dc8b972ea873de8b',
       i686: 'fe9b59efaf6a6413963304800dace25ab731bb265d7b070ed79e846c91485080',
     x86_64: 'a00c65e3763537b970a324daaa38da9c4d3c221c84879c3fc889a83e99e6a1ea'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gmp' => :library
  depends_on 'lapack' => :build
  depends_on 'mpfr' => :library
  depends_on 'openblas' => :library
end
