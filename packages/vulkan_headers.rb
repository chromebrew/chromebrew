require 'buildsystems/cmake'

class Vulkan_headers < CMake
  description 'Vulkan header files'
  homepage 'https://www.khronos.org/vulkan'
  version '1.4.350'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/KhronosGroup/Vulkan-Headers.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '76ad1071c6d8eb7fc70d1e75d6b9561301cefb5c7dda368ec49902dbe53b68d8',
     armv7l: '76ad1071c6d8eb7fc70d1e75d6b9561301cefb5c7dda368ec49902dbe53b68d8',
     x86_64: '7f061d44bceb6ea6056334745766b2443002d5429ca91f3d3bce5e547c79cb2d'
  })
end
