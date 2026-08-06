require 'buildsystems/cmake'

class Mimalloc < CMake
  description 'General-purpose allocator with excellent performance characteristics'
  homepage 'https://github.com/microsoft/mimalloc'
  version '3.4.5'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/microsoft/mimalloc.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f94ebc894cfef670d5a5b0c43562df30d7e94388d0683046884b9fc5d9a0ab72',
     armv7l: 'f94ebc894cfef670d5a5b0c43562df30d7e94388d0683046884b9fc5d9a0ab72',
       i686: '9fe1e5ac760bc7847aa0b79760c46e0ce93aeb624a64aa36299e0ce1c7c2f680',
     x86_64: '6c891ce6e0d88e489e88de8a5f9c3a8f82592fe93afd3af279e9a0b8c0596380'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  cmake_options '-DMI_BUILD_TESTS=OFF'
end
