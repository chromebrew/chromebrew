require 'buildsystems/cmake'

class Eigen < CMake
  description 'Eigen is a C++ template library for linear algebra: matrices, vectors, numerical solvers, and related algorithms.'
  homepage 'https://eigen.tuxfamily.org/index.php?title=Main_Page'
  version '5.0.1'
  license 'MPL-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.com/libeigen/eigen.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ac1ff01116fb8dedc51dc8841064a115544115dbdbc993a7c8828cf2f2dd1d33',
     armv7l: 'ac1ff01116fb8dedc51dc8841064a115544115dbdbc993a7c8828cf2f2dd1d33',
     x86_64: '225564361d0b27e6fc91c35433dad37a792883be40c6ce0e20b233f79127b429'
  })

  depends_on 'boost' => :build
  depends_on 'fftw' => :build
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'mesa' => :build
  depends_on 'mpreal' => :build
  depends_on 'openblas' => :build
  depends_on 'superlu' => :build
end
