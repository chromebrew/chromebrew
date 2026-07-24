require 'buildsystems/cmake'

class Benchmark < CMake
  description 'A microbenchmark support library from Google'
  homepage 'https://github.com/google/benchmark/'
  version '1.9.5'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/google/benchmark.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '82f856bcfcf8702dd147d573c4871d845f7a1595785979264bbb0358f6c5fcc9',
     armv7l: '82f856bcfcf8702dd147d573c4871d845f7a1595785979264bbb0358f6c5fcc9',
       i686: '905e584a18fbd2b63ba803226a6542cd0228657c2cdc11a85c46e8fe27f7a2e9',
     x86_64: '42fbceb0dd337046f01b8181597809332016355f4b473e474fa77c0aecb92764'
  })

  depends_on 'gtest' => :build

  cmake_options ' \
    -DBENCHMARK_ENABLE_ASSEMBLY_TESTS=OFF \
    -DBENCHMARK_ENABLE_GTEST_TESTS=OFF \
    -DBENCHMARK_ENABLE_TESTING=OFF \
    -DBENCHMARK_USE_BUNDLED_GTEST=OFF'
end
