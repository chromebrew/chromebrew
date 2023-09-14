require 'buildsystems/cmake'

class Vulkan_headers < CMake
  description 'Vulkan header files'
  homepage 'https://github.com/KhronosGroup/Vulkan-Headers'
  version '1.3.264'
  license 'Apache-2.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/KhronosGroup/Vulkan-Headers.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_headers/1.3.264_armv7l/vulkan_headers-1.3.264-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_headers/1.3.264_armv7l/vulkan_headers-1.3.264-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_headers/1.3.264_x86_64/vulkan_headers-1.3.264-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f08cfc99f5dad5710f174ef11dd4ae34f92c30caeed9ff33b22e6d243afa60b8',
     armv7l: 'f08cfc99f5dad5710f174ef11dd4ae34f92c30caeed9ff33b22e6d243afa60b8',
     x86_64: '6e23c5d0db6e1bdc44881d30ef80d93792837610a57b38758361b44d3e54ddb0'
  })
end
