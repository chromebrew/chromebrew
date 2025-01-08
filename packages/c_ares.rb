require 'buildsystems/cmake'

class C_ares < CMake
  description 'C library for asynchronous DNS requests (including name resolves).'
  homepage 'https://c-ares.org/'
  version '1.34.3'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/c-ares/c-ares.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '176042a48ab436444760f10e5000ce21f9b09f38074b5427fa71db996e13ff32',
     armv7l: '176042a48ab436444760f10e5000ce21f9b09f38074b5427fa71db996e13ff32',
       i686: '84251436210c524b6fb3d0eeab4c5c1c06814a00521f0322a019b440731b350e',
     x86_64: 'b4f77f816e9417006e93a4da708cd1e57d649621f46bdd1c323b0d0c61808318'
  })

  depends_on 'glibc' # R

  cmake_options '-DCARES_STATIC=ON \
      -DCARES_STATIC_PIC=ON \
      -DCARES_BUILD_TESTS=OFF \
      -DCARES_BUILD_TOOLS=ON \
      -DCARES_SHARED=ON'
end
