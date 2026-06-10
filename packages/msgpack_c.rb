require 'buildsystems/cmake'

class Msgpack_c < CMake
  description 'An efficient object serialization library'
  homepage 'https://github.com/msgpack/msgpack-c'
  version '7.0.1'
  license 'BSL-1.0'
  compatibility 'all'
  source_url 'https://github.com/msgpack/msgpack-c.git'
  git_hashtag "c-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9b61bf97d248985f8505f8687af24fc17a918d2267507891f9769c5aed76cb57',
     armv7l: '9b61bf97d248985f8505f8687af24fc17a918d2267507891f9769c5aed76cb57',
       i686: '614ad290eede0483442431011b9feff614db38ee62a365a6ee8ab1480b4d1040',
     x86_64: 'd2dc49fa5ffda6e7e868b8c9247980c65e4a5558e527aba7a3abab8c8bb1b482'
  })

  depends_on 'doxygen' => :build
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'graphviz' => :build
  depends_on 'gtest' => :build

  cmake_options '-DBUILD_SHARED_LIBS=ON -DMSGPACK_BUILD_TESTS=ON -DMSGPACK_BUILD_EXAMPLES=OFF'

  run_tests
end
