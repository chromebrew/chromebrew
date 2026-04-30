require 'buildsystems/cmake'

class Xsimd < CMake
  description 'C++ wrappers for SIMD intrinsics'
  homepage 'https://github.com/xtensor-stack/xsimd'
  version '14.2.0'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/xtensor-stack/xsimd.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8c5b6f5db2c953c299cde90c3c51cd52300c772efb63d0069d70414e0db2ff9b',
     armv7l: '8c5b6f5db2c953c299cde90c3c51cd52300c772efb63d0069d70414e0db2ff9b',
       i686: '2ad0900a5aaf3616b6e3ee7d893c986412d427ffbd6c255fdbd1b3f5f3f5d712',
     x86_64: 'd212245a93cb8bdb07a3612b3135f4505ed8487ea80a382db7a890ec9717ff4e'
  })
end
