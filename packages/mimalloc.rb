require 'buildsystems/cmake'

class Mimalloc < CMake
  description 'General-purpose allocator with excellent performance characteristics'
  homepage 'https://github.com/microsoft/mimalloc'
  version '1.8.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/microsoft/mimalloc.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2dd4e9762467e71a2da0766300e04ae31880b8f1fc14e5c099f11eabd5fd5664',
     armv7l: '2dd4e9762467e71a2da0766300e04ae31880b8f1fc14e5c099f11eabd5fd5664',
       i686: '50306119b06dbf1d01012611ccd57006b17878ea2b4f8b998a0aeb430ca29235',
     x86_64: '9e309d61984dc9c4640425932cf89f6e3dc82872310b2bc43c89e00213041bed'
  })

  cmake_options '-DMI_BUILD_TESTS=OFF'
end
