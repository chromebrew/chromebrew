require 'buildsystems/cmake'

class Mimalloc < CMake
  description 'General-purpose allocator with excellent performance characteristics'
  homepage 'https://github.com/microsoft/mimalloc'
  version '3.1.5'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/microsoft/mimalloc.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '061446991268120dd6503386b0898a211ff243e15e6f8044e8af974bc9b6e43e',
     armv7l: '061446991268120dd6503386b0898a211ff243e15e6f8044e8af974bc9b6e43e',
       i686: 'bf92dfa8abeb0258bb964013bd351605769567c5015d76df311fae1fe5597520',
     x86_64: '4271bef5854febd99d8ddd383ea3f700957639b6ea8ff92e70b179f62621d72f'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  cmake_options '-DMI_BUILD_TESTS=OFF'
end
