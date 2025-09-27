require 'buildsystems/cmake'

class Vulkan_headers < CMake
  description 'Vulkan header files'
  homepage 'https://www.khronos.org/vulkan'
  version '1.4.328'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/KhronosGroup/Vulkan-Headers.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '72f4323a562270a371e043c4f84385c9b651a890bcdb21849e078ba7574001ef',
     armv7l: '72f4323a562270a371e043c4f84385c9b651a890bcdb21849e078ba7574001ef',
     x86_64: '2b521f9b823421aa38e1d659943c4c1fa6169c17dffbdb08d4b07838d25ab3c5'
  })
end
