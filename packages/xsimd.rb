require 'buildsystems/cmake'

class Xsimd < CMake
  description 'C++ wrappers for SIMD intrinsics'
  homepage 'https://github.com/xtensor-stack/xsimd'
  version '13.2.0'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/xtensor-stack/xsimd.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fa3854ffa913efa3bb6169ab5dfc78f84371a33fd95a55c71e9c2ce4990cdc41',
     armv7l: 'fa3854ffa913efa3bb6169ab5dfc78f84371a33fd95a55c71e9c2ce4990cdc41',
       i686: '0dac1ca2d7465f24777d0d72b98f028f1a783b35a9b51ff33ca3a1b89279d06e',
     x86_64: 'ffe5b730f73df8e5fcac970ac2c55e7e6697480197ef9505f0b0b63d58ac0270'
  })
end
