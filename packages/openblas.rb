require 'buildsystems/cmake'

class Openblas < CMake
  description 'OpenBLAS is an optimized BLAS library'
  homepage 'http://www.openblas.net/'
  version '0.3.10'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/OpenMathLib/OpenBLAS.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openblas/0.3.10_armv7l/openblas-0.3.10-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openblas/0.3.10_armv7l/openblas-0.3.10-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openblas/0.3.10_i686/openblas-0.3.10-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openblas/0.3.10_x86_64/openblas-0.3.10-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '0d21d2d1b5de2552db9b2b3f40acf217b1e634181fe052e430d8e7421d53f4c3',
     armv7l: '0d21d2d1b5de2552db9b2b3f40acf217b1e634181fe052e430d8e7421d53f4c3',
       i686: 'f4ce053cc07aa55bd77f4078eaf7875f5f9dfb266e2faa450ed823e62cc0ef16',
     x86_64: '5ff79ee03d58af432aa664986c4128cc3e8ec95b9e16ced015f48acb8edb4f3c'
  })

  depends_on 'lapack' # R
  cmake_options "-DTARGET=#{%w[x86_64 i686].include?(ARCH) ? 'ATOM' : 'ARMV7'}"
end
