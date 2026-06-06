require 'buildsystems/cmake'

class Vulkan_headers < CMake
  description 'Vulkan header files'
  homepage 'https://www.khronos.org/vulkan'
  version '1.4.353'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/KhronosGroup/Vulkan-Headers.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '57e826465fd559d3d5540c9f777b536a894bb68f7fe251ddbef6689c06eb30af',
     armv7l: '57e826465fd559d3d5540c9f777b536a894bb68f7fe251ddbef6689c06eb30af',
     x86_64: 'c437c1cfc62aaa59348348b628e26708bc9d9abd79248b675611b92334f21a62'
  })
end
