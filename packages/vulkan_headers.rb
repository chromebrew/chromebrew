require 'buildsystems/cmake'

class Vulkan_headers < CMake
  description 'Vulkan header files'
  homepage 'https://github.com/KhronosGroup/Vulkan-Headers'
  version '1.4.327'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/KhronosGroup/Vulkan-Headers.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e82f97e8359e912236ba6a1c57c81eed755996f6da8e3d5147a542ac445aa44a',
     armv7l: 'e82f97e8359e912236ba6a1c57c81eed755996f6da8e3d5147a542ac445aa44a',
     x86_64: '5a4996241568c7f495f9ecbc889eec61d245fcd89c2012f7a2d8866d84b00ed3'
  })
end
