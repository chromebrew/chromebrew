require 'buildsystems/cmake'

class Lapack < CMake
  description 'Lapack is a linear algebra package.'
  homepage 'https://www.netlib.org/lapack/'
  version '3.11.0'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/Reference-LAPACK/lapack.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lapack/3.11.0_armv7l/lapack-3.11.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lapack/3.11.0_armv7l/lapack-3.11.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lapack/3.11.0_i686/lapack-3.11.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lapack/3.11.0_x86_64/lapack-3.11.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '318a9912f69b2f2883c77e9d9b1eb7c63dc5fbfa6751a1792f4b5f793f5400ae',
     armv7l: '318a9912f69b2f2883c77e9d9b1eb7c63dc5fbfa6751a1792f4b5f793f5400ae',
       i686: 'd6e4d4239263523c71773907d3abf1de403867b21cf0b4ba761141a7aeac3752',
     x86_64: '9c4b6ddc16d763f61d79cc7bdc21021f83b6efb06419851ac6a502372f26d850'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
