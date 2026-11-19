require 'buildsystems/cmake'

class Mimalloc < CMake
  description 'General-purpose allocator with excellent performance characteristics'
  homepage 'https://github.com/microsoft/mimalloc'
  version '3.7.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/microsoft/mimalloc.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9ede20733e2996c4feb45a6310fc9e97444b07afd47bf35aefd02d9d800596f4',
     armv7l: '9ede20733e2996c4feb45a6310fc9e97444b07afd47bf35aefd02d9d800596f4',
       i686: 'f3abc2e471c87d0931f8002bf49e998f199feb892a3d26a05be76b2c1991399c',
     x86_64: 'd0711c8f9b7489dd5e3aae60871fd13a0d3d4e295dfa7d82620e9150b08251a0'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  cmake_options '-DMI_BUILD_TESTS=OFF'
end
