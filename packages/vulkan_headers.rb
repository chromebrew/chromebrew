require 'buildsystems/cmake'

class Vulkan_headers < CMake
  description 'Vulkan header files'
  homepage 'https://www.khronos.org/vulkan'
  version '1.4.365'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/KhronosGroup/Vulkan-Headers.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '248c05efa8f4be52c79fde1ae7c0d8ed046c7ff70f774d043c587e71da509691',
     armv7l: '248c05efa8f4be52c79fde1ae7c0d8ed046c7ff70f774d043c587e71da509691',
     x86_64: '471e06a14571612ed4273533af228fed1096d9150ca09910053a79552e735ba4'
  })
end
