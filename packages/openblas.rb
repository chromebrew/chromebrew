require 'buildsystems/cmake'

class Openblas < CMake
  description 'OpenBLAS is an optimized BLAS library'
  homepage 'http://www.openblas.net/'
  version '0.3.33'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/OpenMathLib/OpenBLAS.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '57074b69c26d6f9d39de51b3c48d232899bf52cba161920d5e07b3c3fc8731f3',
     armv7l: '57074b69c26d6f9d39de51b3c48d232899bf52cba161920d5e07b3c3fc8731f3',
       i686: 'f578bfeb86a0315dd05f49c877c1bb46981372c461ab32b6653e7fde421efa3f',
     x86_64: '5e957ac7b6041e4a7958a781d100e52b0678614cb703346ddf23bb348f7dcffd'
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
