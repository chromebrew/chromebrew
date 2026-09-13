require 'buildsystems/cmake'

class Mimalloc < CMake
  description 'General-purpose allocator with excellent performance characteristics'
  homepage 'https://github.com/microsoft/mimalloc'
  version '3.5.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/microsoft/mimalloc.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '17e9c7441b050d2f16f96d0b9e2f5f6f6a900928b8f895c219e745f1d43191ca',
     armv7l: '17e9c7441b050d2f16f96d0b9e2f5f6f6a900928b8f895c219e745f1d43191ca',
       i686: '6d2d05ecc2084dee3fe156804f7388ad2ff10150473649bfdb350a22d5816a7e',
     x86_64: '20dbfe47199ecd9ca5968bfae6d3e424ae016ed9226dcd3245c7aaf224c1a84e'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  cmake_options '-DMI_BUILD_TESTS=OFF'
end
