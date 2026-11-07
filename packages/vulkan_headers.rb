require 'buildsystems/cmake'

class Vulkan_headers < CMake
  description 'Vulkan header files'
  homepage 'https://www.khronos.org/vulkan'
  version '1.4.368'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/KhronosGroup/Vulkan-Headers.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1570aef0582c89a4860364de08b23ae8b98629ea66531c1b52eaf5aab425c118',
     armv7l: '1570aef0582c89a4860364de08b23ae8b98629ea66531c1b52eaf5aab425c118',
     x86_64: '47e568502d3bc54606b672188eda22d58f593890668794af90ce88038d763cab'
  })
end
