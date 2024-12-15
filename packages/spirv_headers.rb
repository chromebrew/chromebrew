require 'buildsystems/cmake'

class Spirv_headers < CMake
  homepage 'https://github.com/KhronosGroup/SPIRV-Headers'
  description 'SPIR-V Headers'
  version '1.3.296.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/SPIRV-Headers.git'
  git_hashtag "vulkan-sdk-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f7121f3344e946fe826ad36bc530b065f9fb8f48d4a38baab53ef1882afe5ce1',
     armv7l: 'f7121f3344e946fe826ad36bc530b065f9fb8f48d4a38baab53ef1882afe5ce1',
       i686: '766f60a4f30774ea819dcf5cfd4f360fac0f33c00b806fad0888fceb520d5f15',
     x86_64: '71983d5f0e170dbb6a8e0f3b6c16d8e6513ed070c497eb9beea1ac18892ba2b8'
  })
end
