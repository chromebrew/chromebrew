require 'buildsystems/cmake'

class Tbb < CMake
  description 'High level abstract threading library'
  homepage 'https://github.com/oneapi-src/oneTBB'
  version '2023.1.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/oneapi-src/oneTBB.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0e59232a6e4f62a126a8c1e57a690203253bde2eda35cccf9698045d6aefba0d',
     armv7l: '0e59232a6e4f62a126a8c1e57a690203253bde2eda35cccf9698045d6aefba0d',
       i686: '701b6034b542a7698c026f5a97b64fab0faca851191bf483460b2c3059bd6e02',
     x86_64: '561f9d71af8d30c680c93fb162436d650d1a4659d2458e923d6edabc54cb3dd5'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'hwloc' => :library
  depends_on 'swig' => :build

  cmake_options '-DTBB4PY_BUILD=ON -DTBB_TEST=OFF'
end
