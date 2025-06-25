require 'buildsystems/cmake'

class Openblas < CMake
  description 'OpenBLAS is an optimized BLAS library'
  homepage 'http://www.openblas.net/'
  version '0.3.30'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/OpenMathLib/OpenBLAS.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '779089640e7fce8bf820b74e1db29164900947ac992ecf760bb4675edc7180c6',
     armv7l: '779089640e7fce8bf820b74e1db29164900947ac992ecf760bb4675edc7180c6',
       i686: '1b178b1b48313ec22667093f1788773dffa3489cf54bf339027b33c390fe99f4',
     x86_64: '858ea3170f99d2b57e21ea73305296565deff31c3ffe29a6698c2660cda02aeb'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'lapack' # R

  no_env_options

  # ARMV7 build target does not work due to incompatibility with vfpv3-d16
  cmake_options "-DTARGET=#{%w[x86_64 i686].include?(ARCH) ? 'ATOM' : 'ARMV6'} \
    -DBUILD_SHARED_LIBS=ON \
    -DBUILD_TESTING=OFF"
end
