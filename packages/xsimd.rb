require 'buildsystems/cmake'

class Xsimd < CMake
  description 'C++ wrappers for SIMD intrinsics'
  homepage 'https://github.com/xtensor-stack/xsimd'
  version '13.1.0'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/xtensor-stack/xsimd.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     armv7l: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
       i686: 'iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii',
     x86_64: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
  })
end
