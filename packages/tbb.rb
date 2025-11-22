require 'buildsystems/cmake'

class Tbb < CMake
  description 'High level abstract threading library'
  homepage 'https://github.com/oneapi-src/oneTBB'
  version '2022.3.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/oneapi-src/oneTBB.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f4e39ecbe901b49bc1923cc10b136b5fd01f5c73148d5d15a4dc78455ad80a07',
     armv7l: 'f4e39ecbe901b49bc1923cc10b136b5fd01f5c73148d5d15a4dc78455ad80a07',
       i686: '7c3f26b5adca0413f399967769810420a00472f96189b98d9f474545da1f8086',
     x86_64: 'e74dd3ba705401c6aba67c459a3522712c56aaacb0768312ddaeb5e5a257f04b'
  })

  depends_on 'hwloc'
  depends_on 'swig' => :build

  cmake_options '-DTBB4PY_BUILD=ON'
  run_tests
end
