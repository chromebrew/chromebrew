require 'buildsystems/cmake'

class Benchmark < CMake
  description 'A microbenchmark support library from Google'
  homepage 'https://github.com/google/benchmark/'
  version '1.9.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/google/benchmark.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c5acbb3c69c92159700d8bff17a9e94358c84aff54e4e30aa55268591e13bbe4',
     armv7l: 'c5acbb3c69c92159700d8bff17a9e94358c84aff54e4e30aa55268591e13bbe4',
       i686: 'b4cc6f68c8e508b50b194d2e16f47fca7fba9389aa9378f87683d02d9a6cc9da',
     x86_64: 'a2eb9d362c7c47f2ce1394549a25b5c7e605a198cc944d7b60e88179a414a60d'
  })

  depends_on 'gtest' => :build

  cmake_options '-DBENCHMARK_USE_BUNDLED_GTEST=OFF'
  run_tests
end
