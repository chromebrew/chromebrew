require 'buildsystems/cmake'

class Openblas < CMake
  description 'OpenBLAS is an optimized BLAS library'
  homepage 'http://www.openblas.net/'
  version '0.3.34'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/OpenMathLib/OpenBLAS.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e2efd5e50741c6f13eff3494f4b7a3739d7683d9001d0d16a2435bd158820940',
     armv7l: 'e2efd5e50741c6f13eff3494f4b7a3739d7683d9001d0d16a2435bd158820940',
       i686: '94b625a94044872bf96c67810741a30fffbd223f415d944ebf0f71385e488ab6',
     x86_64: '9bb483ebbdd08acf588971888419bfecf9ee4da41f7bdba0930407cd5378d24a'
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
