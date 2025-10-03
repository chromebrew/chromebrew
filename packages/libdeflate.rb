require 'buildsystems/cmake'

class Libdeflate < CMake
  description 'Heavily optimized library for DEFLATE compression and decompression'
  homepage 'https://github.com/ebiggers/libdeflate/'
  version '1.24'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ebiggers/libdeflate.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '40a0c187a36367bdf09c97de3fa4b90509e3112edac18854be41a135864fbbb9',
     armv7l: '40a0c187a36367bdf09c97de3fa4b90509e3112edac18854be41a135864fbbb9',
       i686: 'd27617a9a2063476dad592d162dac5f785b6335a60c930d152ecbd6cf3e7d10d',
     x86_64: '99959a610d6b73901ad6285cf2d8ed2fa298a6d5caf71610bc56aa4ca5ffaff4'
  })

  depends_on 'glibc' # R
end
