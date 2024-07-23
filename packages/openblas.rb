require 'buildsystems/cmake'

class Openblas < CMake
  description 'OpenBLAS is an optimized BLAS library'
  homepage 'http://www.openblas.net/'
  version '0.3.25'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/OpenMathLib/OpenBLAS.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '478415d5fbc9713a3e6250118d1fd04a787bd7856d3f717efced52cfb9e9cf94',
     armv7l: '478415d5fbc9713a3e6250118d1fd04a787bd7856d3f717efced52cfb9e9cf94',
       i686: '05eb515b7a560aed510a93dcecbad80ea9a477b7c89580f4e498cb5c11a7ec8b',
     x86_64: '5e62fdd1ffd74b00d730b4ce04d16eac1fb43c63ecbdae45a301b7051dc85a41'
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
