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
    aarch64: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     armv7l: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
       i686: 'iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii',
     x86_64: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
  })

  depends_on 'hwloc'
  depends_on 'swig' => :build

  cmake_options '-DTBB4PY_BUILD=ON -DTBB_TEST=OFF'
end
