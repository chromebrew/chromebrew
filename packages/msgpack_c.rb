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
    aarch64: '1189e6489f7bc4cb2e33dc2e789d7f0e35af35aae6022b8b5054c700fdefa8e8',
     armv7l: '1189e6489f7bc4cb2e33dc2e789d7f0e35af35aae6022b8b5054c700fdefa8e8',
       i686: 'a5872ba8b59735fefce6840c35e285b40266ecb473b42411c08b07e84a5134f1',
     x86_64: 'ea64ea8910c60a69a68a9b9af4c5e27a0954c325993a4dd1e6dbaa2d1d535434'
  })

  depends_on 'doxygen' => :build
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'graphviz' => :build
  depends_on 'gtest' => :build

  cmake_options '-DBUILD_SHARED_LIBS=ON -DMSGPACK_BUILD_TESTS=ON -DMSGPACK_BUILD_EXAMPLES=OFF'

  run_tests
end
