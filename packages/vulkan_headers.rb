require 'buildsystems/cmake'

class Vulkan_headers < CMake
  description 'Vulkan header files'
  homepage 'https://www.khronos.org/vulkan'
  version '1.4.352'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/KhronosGroup/Vulkan-Headers.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a3f468695c0330badada7bd34037d92d2ddb590b520f4268bc62f4e38721a7e1',
     armv7l: 'a3f468695c0330badada7bd34037d92d2ddb590b520f4268bc62f4e38721a7e1',
     x86_64: '1651b8d9fbd23a7d9584667a30dfd06faa1f76010a221f282ca49ff298801352'
  })
end
