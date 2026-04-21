require 'buildsystems/cmake'

class Mimalloc < CMake
  description 'General-purpose allocator with excellent performance characteristics'
  homepage 'https://github.com/microsoft/mimalloc'
  version '3.3.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/microsoft/mimalloc.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '80ba75f499fa32568b8da3e71ed17de1bd9ef38cb3a0a6845cbe7ffdf711484a',
     armv7l: '80ba75f499fa32568b8da3e71ed17de1bd9ef38cb3a0a6845cbe7ffdf711484a',
       i686: '5f8a10a924b8314910c6e70f93b533643fa347d1475626f038b1ac6ed605e7fc',
     x86_64: 'dce58d93620b0f6193e1d5f7edafe203f17adcf44672199950ee1660efb96236'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library

  cmake_options '-DMI_BUILD_TESTS=OFF'
end
