require 'buildsystems/cmake'

class Mimalloc < CMake
  description 'General-purpose allocator with excellent performance characteristics'
  homepage 'https://github.com/microsoft/mimalloc'
  version '3.4.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/microsoft/mimalloc.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b44dbfbe8c13ee885b05b166ff104b18453225405c6b5269f9b805233c8e0509',
     armv7l: 'b44dbfbe8c13ee885b05b166ff104b18453225405c6b5269f9b805233c8e0509',
       i686: 'cb1b6f90b5d3fe1c4293184f3470bbd9325915358efdf98a54c339c49d3da2b9',
     x86_64: 'd05a692cd2c2697ae95fb9667709355850d0b4f9866b4a4f0748b204733a74a5'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library

  cmake_options '-DMI_BUILD_TESTS=OFF'
end
