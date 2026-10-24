require 'buildsystems/cmake'

class Mimalloc < CMake
  description 'General-purpose allocator with excellent performance characteristics'
  homepage 'https://github.com/microsoft/mimalloc'
  version '3.6.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/microsoft/mimalloc.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f919e1a3173cfc7d796d248f815792fdf98e8d9c90e1eea5e935cdb73c66f5d4',
     armv7l: 'f919e1a3173cfc7d796d248f815792fdf98e8d9c90e1eea5e935cdb73c66f5d4',
       i686: '9027639e43d5ad1f13a1165ac5f7992b6a62ad98482483612b16f68c15b6428a',
     x86_64: '1a60f98806cce2ca6e3b637b737dff89acbf728309c2706aa9d35c103e925a41'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  cmake_options '-DMI_BUILD_TESTS=OFF'
end
