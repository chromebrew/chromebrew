require 'buildsystems/cmake'

class Vulkan_headers < CMake
  description 'Vulkan header files'
  homepage 'https://www.khronos.org/vulkan'
  version '1.4.366'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/KhronosGroup/Vulkan-Headers.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'df83205a8d5794791918f440fcb0192e2f3248ac67f3d4e6b03ca92576d1a5f2',
     armv7l: 'df83205a8d5794791918f440fcb0192e2f3248ac67f3d4e6b03ca92576d1a5f2',
     x86_64: '26d226247be3a7b2afff8e9e14bf8f2bd1186897afb492147d70426253d0b1f6'
  })
end
