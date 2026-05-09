require 'buildsystems/cmake'

class Vulkan_headers < CMake
  description 'Vulkan header files'
  homepage 'https://www.khronos.org/vulkan'
  version '1.4.351'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/KhronosGroup/Vulkan-Headers.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f26b1e1e4ba1998a1658a19dae528ee7cec1e049ca1925de7fcf35a499628b27',
     armv7l: 'f26b1e1e4ba1998a1658a19dae528ee7cec1e049ca1925de7fcf35a499628b27',
     x86_64: '6bcbea844658a722ede70c2e251a45464c789078f8abc0dc9f23f38334b097e4'
  })
end
