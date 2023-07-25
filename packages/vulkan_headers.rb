require 'buildsystems/cmake'

class Vulkan_headers < CMake
  description 'Vulkan header files'
  homepage 'https://github.com/KhronosGroup/Vulkan-Headers'
  version '1.3.258'
  license 'Apache-2.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/KhronosGroup/Vulkan-Headers.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_headers/1.3.258_armv7l/vulkan_headers-1.3.258-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_headers/1.3.258_armv7l/vulkan_headers-1.3.258-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_headers/1.3.258_x86_64/vulkan_headers-1.3.258-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd896273175df3b436bdcce6005d5ac50d2a1c4f21353cace59edc7657c16b931',
     armv7l: 'd896273175df3b436bdcce6005d5ac50d2a1c4f21353cace59edc7657c16b931',
     x86_64: '4f8de72e34987aaeed339b9622b0de47b731d607ad92e2139d2ddc5187662147'
  })
end
