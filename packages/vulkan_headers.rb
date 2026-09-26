require 'buildsystems/cmake'

class Vulkan_headers < CMake
  description 'Vulkan header files'
  homepage 'https://www.khronos.org/vulkan'
  version '1.4.364'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/KhronosGroup/Vulkan-Headers.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '08ac1547bb6b20d4ba0c5b9f21a421d4b6a7fd9176ed5087025b8c00ce73f409',
     armv7l: '08ac1547bb6b20d4ba0c5b9f21a421d4b6a7fd9176ed5087025b8c00ce73f409',
     x86_64: 'fe43b10100501f0f543e58473348dcf3eef3b0164dd1c9490883a84f9c29a57f'
  })
end
