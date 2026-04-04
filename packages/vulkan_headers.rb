require 'buildsystems/cmake'

class Vulkan_headers < CMake
  description 'Vulkan header files'
  homepage 'https://www.khronos.org/vulkan'
  version '1.4.348'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/KhronosGroup/Vulkan-Headers.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '14624820dc71bf349d7ddd6d9258b6fb926c92b1b1d36ec83b4a8fc9e478068f',
     armv7l: '14624820dc71bf349d7ddd6d9258b6fb926c92b1b1d36ec83b4a8fc9e478068f',
     x86_64: 'c88dab89c9b7cff6c9c133e77389b21904e6546ecc1fba2b6bb8e6dfe8cd87c5'
  })
end
