require 'buildsystems/cmake'

class Benchmark < CMake
  description 'A microbenchmark support library from Google'
  homepage 'https://github.com/google/benchmark/'
  version '1.9.4'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/google/benchmark.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b62bb1b03e6ae3b22ded2802f583b645ff85d44df14e243764aed9fb40790334',
     armv7l: 'b62bb1b03e6ae3b22ded2802f583b645ff85d44df14e243764aed9fb40790334',
       i686: '4827580647fedd10593b7f7b1fa33ccbd879138c9a133e839eda2db6b004a42e',
     x86_64: '9e7c4cde27998cfa84602cc60150f6256898b5cb4910344187363bb9354eaad0'
  })

  depends_on 'gtest' => :build

  cmake_options '-DBENCHMARK_USE_BUNDLED_GTEST=OFF'
  run_tests
end
