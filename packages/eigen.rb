require 'buildsystems/cmake'

class Eigen < CMake
  description 'Eigen is a C++ template library for linear algebra: matrices, vectors, numerical solvers, and related algorithms.'
  homepage 'http://eigen.tuxfamily.org/'
  version '3.4.0-1'
  license 'MPL-2.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.com/libeigen/eigen/-/archive/3.4.0/eigen-3.4.0.tar.bz2'
  source_sha256 'b4c198460eba6f28d34894e3a5710998818515104d6e74e5cc331ce31e46e626'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/eigen/3.4.0-1_armv7l/eigen-3.4.0-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/eigen/3.4.0-1_armv7l/eigen-3.4.0-1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/eigen/3.4.0-1_x86_64/eigen-3.4.0-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e7c0d128ac5b97411dad488756a79d7ecd54a23184281e11c73edb066dff5b75',
     armv7l: 'e7c0d128ac5b97411dad488756a79d7ecd54a23184281e11c73edb066dff5b75',
     x86_64: 'a87ea3dbfdfc82cb123d5692bc33c4e41702c6be0df5d1ea467b14585e1f1066'
  })

  depends_on 'boost' => :build
  depends_on 'fftw' => :build
  depends_on 'mesa' => :build
  depends_on 'superlu' => :build
end
