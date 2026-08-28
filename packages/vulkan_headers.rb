require 'buildsystems/cmake'

class Vulkan_headers < CMake
  description 'Vulkan header files'
  homepage 'https://www.khronos.org/vulkan'
  version '1.4.361'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/KhronosGroup/Vulkan-Headers.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aa0091ead802eba4f96e6f34dd15363337179aa27ada9b96a931d7336f9abbd4',
     armv7l: 'aa0091ead802eba4f96e6f34dd15363337179aa27ada9b96a931d7336f9abbd4',
     x86_64: '05a00d657b40a46694d675bee26d389bcfcc71f8e8750bd49db3698354306901'
  })
end
