require 'buildsystems/cmake'

class Vulkan_headers < CMake
  description 'Vulkan header files'
  homepage 'https://www.khronos.org/vulkan'
  version '1.4.358'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/KhronosGroup/Vulkan-Headers.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8fdaf6e60ef2a11e5028f43de040105bda109a63d7166e8e48d7ffff7dc9082d',
     armv7l: '8fdaf6e60ef2a11e5028f43de040105bda109a63d7166e8e48d7ffff7dc9082d',
     x86_64: '1f6f23b6b9745f3d3bbaacbbe9f166ca2b7effce6eaa09ef78172d04951aea9b'
  })
end
