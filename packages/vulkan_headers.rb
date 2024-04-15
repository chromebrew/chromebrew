require 'buildsystems/cmake'

class Vulkan_headers < CMake
  description 'Vulkan header files'
  homepage 'https://github.com/KhronosGroup/Vulkan-Headers'
  version '1.3.281'
  license 'Apache-2.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/KhronosGroup/Vulkan-Headers.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '593bff4ddd1ea0491d4bc9c0d74783ac8656e5e921b23c2c36a2c78ba8d56b2e',
     armv7l: '593bff4ddd1ea0491d4bc9c0d74783ac8656e5e921b23c2c36a2c78ba8d56b2e',
     x86_64: '0ea4a38f95b179f9504cf6518c5c9b4c5dc9a5fc4cdd7607c7fdf5eb7dcf5d03'
  })
end
