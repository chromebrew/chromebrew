require 'buildsystems/cmake'

class Spirv_headers < CMake
  homepage 'https://github.com/KhronosGroup/SPIRV-Headers'
  description 'SPIR-V Headers'
  version '2026.08.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/SPIRV-Headers.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'af159ab9eedc60b51d402eb3a1c48368e4f25a48ad127a5b0bafe17fe544af98',
     armv7l: 'af159ab9eedc60b51d402eb3a1c48368e4f25a48ad127a5b0bafe17fe544af98',
       i686: '60f6a1b5d86d1acae8f5e2f8edb063d24756d8a52920e8a65624ed5c2687242c',
     x86_64: '4d33791eb9475ce9c9582e02b155207f8ff6523dae4d6ab136764e82fb26f59f'
  })
end
