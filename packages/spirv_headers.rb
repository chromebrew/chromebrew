require 'buildsystems/cmake'

class Spirv_headers < CMake
  homepage 'https://github.com/KhronosGroup/SPIRV-Headers'
  description 'SPIR-V Headers'
  version '2026.08.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/SPIRV-Headers.git'
  git_hashtag "vulkan-sdk-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '50c9497b34e32d8d9e61e5c28619adb4b1ded51d44c79e11d70e4ff521fe95ef',
     armv7l: '50c9497b34e32d8d9e61e5c28619adb4b1ded51d44c79e11d70e4ff521fe95ef',
       i686: '1d19d10a15befb7059bbc4b4a72d4ed71d1d33d8dfdb9d3d3cd2bb5c9a21b43b',
     x86_64: 'f7fcb48ead5998268225182832978e058ec6f98636d38335f141c6d07e68bb70'
  })
end
