require 'buildsystems/cmake'

class Spirv_headers < CMake
  homepage 'https://github.com/KhronosGroup/SPIRV-Headers'
  description 'SPIR-V Headers'
  version '1.5.4.raytracing.fixed'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/SPIRV-Headers.git'
  git_hashtag "vulkan-sdk-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'efaa3b79dcab79a12be1b4351aea6fad98bf91f031bc9719cd6cf9208ad05d21',
     armv7l: 'efaa3b79dcab79a12be1b4351aea6fad98bf91f031bc9719cd6cf9208ad05d21',
       i686: '902ef99c7dad4ea52f3db11b01ab779dd1016128deec407a045f77d3d49d7511',
     x86_64: '546020c8634530ac187ee9b7b5960a4671723658af9ae8b131bf13d8c6e74b32'
  })
end
