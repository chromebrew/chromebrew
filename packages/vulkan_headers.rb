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
    aarch64: '6bfa77851a2f35e823f1e7f055ef9db017935a90443beb269f4d5e30a5846a29',
     armv7l: '6bfa77851a2f35e823f1e7f055ef9db017935a90443beb269f4d5e30a5846a29',
     x86_64: '18b02e0d74191a951869f75e919a5c54893676ebbd2d9ccff4fc3df8cfd07233'
  })
end
