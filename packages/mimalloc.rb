require 'buildsystems/cmake'

class Mimalloc < CMake
  description 'General-purpose allocator with excellent performance characteristics'
  homepage 'https://github.com/microsoft/mimalloc'
  version '3.3.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/microsoft/mimalloc.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '68c624bcc0865d45cd64b7ac9c940c55a3bde0db07172ce2116a0e2fac4541c9',
     armv7l: '68c624bcc0865d45cd64b7ac9c940c55a3bde0db07172ce2116a0e2fac4541c9',
       i686: '3c2cb30b2daee57308bb6dcb7e049474d3fbd5a3913efd03e092a1ac3c79d92b',
     x86_64: 'faaaa6f562e695d536ed770782d9b6ec595cc7b84733a0b87067c48dc0d04600'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library

  cmake_options '-DMI_BUILD_TESTS=OFF'
end
