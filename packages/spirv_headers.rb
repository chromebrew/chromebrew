require 'buildsystems/cmake'

class Spirv_headers < CMake
  homepage 'https://github.com/KhronosGroup/SPIRV-Headers'
  description 'SPIR-V Headers'
  version '1.4.304.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/SPIRV-Headers.git'
  git_hashtag "vulkan-sdk-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b5b9e152976bf7dbcb96d966d87ab07498381de86c78351c534e15f62d3874e2',
     armv7l: 'b5b9e152976bf7dbcb96d966d87ab07498381de86c78351c534e15f62d3874e2',
       i686: 'edd851d7789ccc68665c55ebe65466100417ddf1268fb2673a5e0b7700dd71fb',
     x86_64: 'be5fdf0c9ee640358cad6673b67e87ac2bb5f54bf58c533614fb7b03a7674587'
  })
end
