require 'buildsystems/cmake'

class Mimalloc < CMake
  description 'General-purpose allocator with excellent performance characteristics'
  homepage 'https://github.com/microsoft/mimalloc'
  version '3.5.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/microsoft/mimalloc.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c44c9862eee4e8a18eb5276548e41674ff071a7cab7fe1d46d20a9fc88083dad',
     armv7l: 'c44c9862eee4e8a18eb5276548e41674ff071a7cab7fe1d46d20a9fc88083dad',
       i686: '3f147e37fc4ca05e05899f90e9d7d4a1a1164c280477f4c1e845978adbf08932',
     x86_64: 'f82e2c02196505e6e35014c46b795a87bf3755fa1a31c68ed8614609777e84aa'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  cmake_options '-DMI_BUILD_TESTS=OFF'
end
