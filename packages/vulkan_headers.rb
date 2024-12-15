require 'buildsystems/cmake'

class Vulkan_headers < CMake
  description 'Vulkan header files'
  homepage 'https://github.com/KhronosGroup/Vulkan-Headers'
  version '1.4.303'
  license 'Apache-2.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/KhronosGroup/Vulkan-Headers.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '895f12a973b319fa30e57835001675fca677b9128b7d8ee2fbd7cc40cc2af4b1',
     armv7l: '895f12a973b319fa30e57835001675fca677b9128b7d8ee2fbd7cc40cc2af4b1',
     x86_64: '95df33b08db9c3bd6b73bd4a3983e55ea85b65707f0bc76f32aed12a0075fc02'
  })
end
