require 'buildsystems/cmake'

class Openblas < CMake
  description 'OpenBLAS is an optimized BLAS library'
  homepage 'http://www.openblas.net/'
  version '0.3.31'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/OpenMathLib/OpenBLAS.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4de9367187751c153dae7e7274bcc13ce7a94ec9724dfd63518d98e9c435e452',
     armv7l: '4de9367187751c153dae7e7274bcc13ce7a94ec9724dfd63518d98e9c435e452',
       i686: 'f08011f068fbd5e7b12c12b7899a997ff12b81b22fbc6d686d208ea6dcd3bd04',
     x86_64: '6fd324e18cc8e5276e4c9c0cc815501d4ea70cbf58efaac1e1f55010de03dad3'
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
