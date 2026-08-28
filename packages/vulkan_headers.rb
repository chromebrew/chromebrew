require 'buildsystems/cmake'

class Vulkan_headers < CMake
  description 'Vulkan header files'
  homepage 'https://www.khronos.org/vulkan'
  version '1.4.361'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/KhronosGroup/Vulkan-Headers.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f42c5e4b7c75f498b58fa5f92f775cdd617b67f7758bf7a630cd7127336bb78a',
     armv7l: 'f42c5e4b7c75f498b58fa5f92f775cdd617b67f7758bf7a630cd7127336bb78a',
     x86_64: '2c3b09a2c0224b3795b5187a24638f69b6daff12ee0d5cc992059e7ad99f9b0d'
  })
end
