require 'buildsystems/cmake'

class Spirv_headers < CMake
  homepage 'https://github.com/KhronosGroup/SPIRV-Headers'
  description 'SPIR-V Headers'
  version '1.3.290.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/SPIRV-Headers.git'
  git_hashtag "vulkan-sdk-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '55568d36faf09b8793a8a89da489acc93b9839423ac198b5b01f9d6fe7e5ebf7',
     armv7l: '55568d36faf09b8793a8a89da489acc93b9839423ac198b5b01f9d6fe7e5ebf7',
       i686: '0b25562e655bad67cd6348c23968808ea42c5547823082161e899ab8e6046923',
     x86_64: '38d108fc91c151efdd1035c30cd53e64237c7a7acf220617955e015fa75e73e5'
  })
end
