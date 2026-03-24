require 'buildsystems/cmake'

class Openblas < CMake
  description 'OpenBLAS is an optimized BLAS library'
  homepage 'http://www.openblas.net/'
  version '0.3.32'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/OpenMathLib/OpenBLAS.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8b2b14a6c57e22afca4a0c530e551b8bdf573c57c1ad61c6db7d83cf9edc069a',
     armv7l: '8b2b14a6c57e22afca4a0c530e551b8bdf573c57c1ad61c6db7d83cf9edc069a',
       i686: '66ef405e7ac491e7144be99f1cc8ff90f4684df6dc6058b8cebcafce961eab44',
     x86_64: '44002f3366754fd9867b1183858689dbe96fc58f91d1292b8d59cf7ab18517e2'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'lapack' # R

  no_env_options

  # ARMV7 build target does not work due to incompatibility with vfpv3-d16
  cmake_options "-DTARGET=#{%w[x86_64 i686].include?(ARCH) ? 'ATOM' : 'ARMV6'} \
    -DBUILD_SHARED_LIBS=ON \
    -DBUILD_TESTING=OFF"
end
