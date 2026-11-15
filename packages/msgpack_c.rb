require 'buildsystems/cmake'

class Msgpack_c < CMake
  description 'An efficient object serialization library'
  homepage 'https://github.com/msgpack/msgpack-c'
  version '7.0.2'
  license 'BSL-1.0'
  compatibility 'all'
  source_url 'https://github.com/msgpack/msgpack-c.git'
  git_hashtag "c-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '006c33ced2b58d29ea0f93dbfc1b4ecb8248b6e230980df3e381142015719b5f',
     armv7l: '006c33ced2b58d29ea0f93dbfc1b4ecb8248b6e230980df3e381142015719b5f',
       i686: '2296f1525dce51d1a5e79aae16a496e54e5179a844897139fdbfa90b5094c464',
     x86_64: '432f23bcf80010f3ab4c9e2ec51f5dbf7ae0decd696c04243e20dbaa0335e589'
  })

  depends_on 'doxygen' => :build
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'graphviz' => :build
  depends_on 'gtest' => :build

  cmake_options '-DBUILD_SHARED_LIBS=ON -DMSGPACK_BUILD_TESTS=ON -DMSGPACK_BUILD_EXAMPLES=OFF'

  run_tests
end
