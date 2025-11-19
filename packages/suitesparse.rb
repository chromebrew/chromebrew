require 'buildsystems/cmake'

class Suitesparse < CMake
  description 'A suite of sparse matrix software'
  homepage 'https://people.engr.tamu.edu/davis/suitesparse.html'
  version '7.12.1'
  license 'metapackage'
  compatibility 'all'
  source_url 'https://github.com/DrTimothyAldenDavis/SuiteSparse.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '74d600ca187a132cf02c1e289ead0cbe3640eecaad64ad9bee1235f11b4006d8',
     armv7l: '74d600ca187a132cf02c1e289ead0cbe3640eecaad64ad9bee1235f11b4006d8',
       i686: '7bf702d27beb0d0bccc0827740150ead66e4a2ecfc06ef9e20a544bb3597610b',
     x86_64: 'fdfdf549665de7b7fc194a939730154d1325052e7ebbcb0623b7c6a036db3d92'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'lapack' => :build
  depends_on 'mpfr' # R
  depends_on 'openblas' # R
end
