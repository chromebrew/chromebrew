require 'package'

class Eigen < Package
  description 'Eigen is a C++ template library for linear algebra: matrices, vectors, numerical solvers, and related algorithms.'
  homepage 'http://eigen.tuxfamily.org/'
  version '3.4.0'
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'https://gitlab.com/libeigen/eigen/-/archive/3.4.0/eigen-3.4.0.tar.bz2'
  source_sha256 'b4c198460eba6f28d34894e3a5710998818515104d6e74e5cc331ce31e46e626'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/eigen/3.4.0_armv7l/eigen-3.4.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/eigen/3.4.0_armv7l/eigen-3.4.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/eigen/3.4.0_i686/eigen-3.4.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/eigen/3.4.0_x86_64/eigen-3.4.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4e98dce7b77978aff8f6991edcc18577e79728f71cda1753a5b3fa75165e141b',
     armv7l: '4e98dce7b77978aff8f6991edcc18577e79728f71cda1753a5b3fa75165e141b',
       i686: 'ba97ef42530781794fab541b020104184c188d56c4e13c2de0924b835bd539cb',
     x86_64: 'b9275bcb88a8f123b1568f23f723f2340b955fb5323845e0891b98596e8813cf'
  })

  depends_on 'boost' => :build
  depends_on 'fftw' => :build
  depends_on 'mesa' => :build
  depends_on 'superlu' => :build

  def self.build
    system "cmake -B builddir #{CREW_CMAKE_OPTIONS} \
            -G Ninja"
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
