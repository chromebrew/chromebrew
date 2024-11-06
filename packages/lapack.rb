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
