require 'buildsystems/cmake'

class Spirv_headers < CMake
  homepage 'https://github.com/KhronosGroup/SPIRV-Headers'
  description 'SPIR-V Headers'
  version '1.4.350.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/SPIRV-Headers.git'
  git_hashtag "vulkan-sdk-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '84a1de4c7973e836e280a2aaeb04eca604bf94a16962f045cabe0d415530ccce',
     armv7l: '84a1de4c7973e836e280a2aaeb04eca604bf94a16962f045cabe0d415530ccce',
       i686: '6c990054b11269bd2b276880b171cd4315385a60804a63546f8e46272e56aac6',
     x86_64: '9a0f41c262ffa7d668ef31b7124dda31fadd5c303173daacde66ff9cf5874c92'
  })
end
