require 'buildsystems/cmake'

class Msgpack_c < CMake
  description 'An efficient object serialization library'
  homepage 'https://github.com/msgpack/msgpack-c'
  version '6.0.1'
  license 'BSL-1.0'
  compatibility 'all'
  source_url 'https://github.com/msgpack/msgpack-c.git'
  git_hashtag "c-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '06550bcf508a6afe4e7179194b537f967f4577cb7c89f66c9cfd3baa579d6074',
     armv7l: '06550bcf508a6afe4e7179194b537f967f4577cb7c89f66c9cfd3baa579d6074',
       i686: '86fe5469cd32609648ac32bb6a2347f730a00ae1e4adaff8c8861aeb99859327',
     x86_64: 'f4c07ff6634eaf48926ade547924086349bbdc8218f69038b7be219a9c544c11'
  })

  depends_on 'doxygen' => :build
  depends_on 'glibc' # R
  depends_on 'gtest' => :build

  cmake_options '-DBUILD_SHARED_LIBS=ON -DMSGPACK_BUILD_TESTS=ON -DMSGPACK_BUILD_EXAMPLES=OFF'

  run_tests
end
