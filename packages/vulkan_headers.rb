require 'buildsystems/cmake'

class Vulkan_headers < CMake
  description 'Vulkan header files'
  homepage 'https://www.khronos.org/vulkan'
  version '1.4.349'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/KhronosGroup/Vulkan-Headers.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '891dba7d6dcf6810f75200cbd268307e64302d0e4f50653bfdb0d74b254a1c27',
     armv7l: '891dba7d6dcf6810f75200cbd268307e64302d0e4f50653bfdb0d74b254a1c27',
     x86_64: '49a912d94241083775edbfb6b854bdc2f360bdc3316faa5831952d4e249e3f35'
  })
end
