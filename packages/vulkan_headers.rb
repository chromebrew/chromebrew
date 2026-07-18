require 'buildsystems/cmake'

class Vulkan_headers < CMake
  description 'Vulkan header files'
  homepage 'https://www.khronos.org/vulkan'
  version '1.4.357'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/KhronosGroup/Vulkan-Headers.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '333bb6bb47390753bbab116bb3e8697b18e852836d11808eb7195f63ad3c0423',
     armv7l: '333bb6bb47390753bbab116bb3e8697b18e852836d11808eb7195f63ad3c0423',
     x86_64: '30ce0712d10b0a6fbe6fbf3aa37ce87e9b60709caaad3d1109111b2dd41b8576'
  })
end
