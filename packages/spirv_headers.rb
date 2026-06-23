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
    aarch64: '442712c4827a134ecb6e34a6795256e7feeed5d82291191030a59dba5ddb7d16',
     armv7l: '442712c4827a134ecb6e34a6795256e7feeed5d82291191030a59dba5ddb7d16',
       i686: 'c9d31d8a2eafb815d72af0f8ceee83d5f5f0cff82cbf0bfb6b01995dcc1d36c7',
     x86_64: 'dbe64c7052b0dbc5e1452ef0c3ab09c2cf6638493edd423453fb33ae5be67f5d'
  })
end
