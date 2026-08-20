require 'buildsystems/cmake'

class Mimalloc < CMake
  description 'General-purpose allocator with excellent performance characteristics'
  homepage 'https://github.com/microsoft/mimalloc'
  version '3.5.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/microsoft/mimalloc.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9d34bc7fc1d5f001b46bdbfe1cb05eb0f0d54b55e00cc8cdf0cfbe32f76192da',
     armv7l: '9d34bc7fc1d5f001b46bdbfe1cb05eb0f0d54b55e00cc8cdf0cfbe32f76192da',
       i686: 'cd41433fdb0480e2d87398c715d406326384d0624c71d0f1cba6a3f8f61d513d',
     x86_64: 'c43fadfac3e9ff5e6fc120c0d778ddfc053d85ce955dea896644bad784e15a1d'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  cmake_options '-DMI_BUILD_TESTS=OFF'
end
