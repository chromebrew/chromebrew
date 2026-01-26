require 'buildsystems/cmake'

class Immer < CMake
  description 'Postmodern immutable and persistent data structures for C++'
  homepage 'https://github.com/arximboldi/immer'
  version '0.9.1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/arximboldi/immer.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6b26c47b880ef56aa4d95a8cdc06239e031c7b09560b383def107a36e60011d2',
     armv7l: '6b26c47b880ef56aa4d95a8cdc06239e031c7b09560b383def107a36e60011d2',
       i686: 'c2d3ad070fe8996f9cac4f953aa11ceccf1e49b46cb508636e7681138da00f57',
     x86_64: '3c2ab7e58b2352661164c1247124f3dea4024119c04ba9b5f6119e71b56bae8c'
  })

  cmake_options '-Dimmer_BUILD_TESTS=OFF -Dimmer_BUILD_EXTRAS=OFF -Dimmer_BUILD_EXAMPLES=OFF'
end
