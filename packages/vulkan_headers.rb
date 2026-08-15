require 'buildsystems/cmake'

class Vulkan_headers < CMake
  description 'Vulkan header files'
  homepage 'https://www.khronos.org/vulkan'
  version '1.4.360'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/KhronosGroup/Vulkan-Headers.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4e53ca24dfef60f2377a1943c8ce3d36d1d4f47469aaae6bc454e17b0448a7d4',
     armv7l: '4e53ca24dfef60f2377a1943c8ce3d36d1d4f47469aaae6bc454e17b0448a7d4',
     x86_64: 'a17ac1383f259b82b5affe013f554a6fb06c8d957ef6b925d3300777b11a3d15'
  })
end
