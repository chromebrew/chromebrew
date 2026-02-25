require 'buildsystems/cmake'

class Msgpack_c < CMake
  description 'An efficient object serialization library'
  homepage 'https://github.com/msgpack/msgpack-c'
  version '6.1.0'
  license 'BSL-1.0'
  compatibility 'all'
  source_url 'https://github.com/msgpack/msgpack-c.git'
  git_hashtag "c-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '25871fb0aff5a17a2d0fbddc41323d49fce7f4172fccb85ff48c570b1577897c',
     armv7l: '25871fb0aff5a17a2d0fbddc41323d49fce7f4172fccb85ff48c570b1577897c',
       i686: 'c15170bb6dd6d3e1b352e6ce79c989d091cf81dbcf76aaf2dc67f7f8759e8b03',
     x86_64: '50f238300cb00c810d89b0557e8298f9075436fd2f84859db7d2b5603e2b1132'
  })

  depends_on 'doxygen' => :build
  depends_on 'glibc' # R
  depends_on 'graphviz' => :build
  depends_on 'gtest' => :build

  cmake_options '-DBUILD_SHARED_LIBS=ON -DMSGPACK_BUILD_TESTS=ON -DMSGPACK_BUILD_EXAMPLES=OFF'

  run_tests
end
