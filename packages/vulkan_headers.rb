require 'buildsystems/cmake'

class Vulkan_headers < CMake
  description 'Vulkan header files'
  homepage 'https://www.khronos.org/vulkan'
  version '1.4.362'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/KhronosGroup/Vulkan-Headers.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8fa91ad5eefc6620c106524a319e123e07402e9bf891acd0c37794811dfd1d97',
     armv7l: '8fa91ad5eefc6620c106524a319e123e07402e9bf891acd0c37794811dfd1d97',
     x86_64: '9c18f11d6d1d18cb9e1b0b09f92bdf8075cd34d3b7d6d792bc91852cf1aa2953'
  })
end
