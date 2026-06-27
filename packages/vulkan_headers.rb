require 'buildsystems/cmake'

class Vulkan_headers < CMake
  description 'Vulkan header files'
  homepage 'https://www.khronos.org/vulkan'
  version '1.4.355'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/KhronosGroup/Vulkan-Headers.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6e11f460772cc1d3ecd25e63bedd84ddddbc1c8d72e15fe108ba1970fa6dd953',
     armv7l: '6e11f460772cc1d3ecd25e63bedd84ddddbc1c8d72e15fe108ba1970fa6dd953',
     x86_64: 'dae810032b053d2816abb0320d3b7827f843b6a12b851515677385622ebdfb07'
  })
end
