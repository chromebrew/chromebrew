require 'buildsystems/cmake'

class Vulkan_headers < CMake
  description 'Vulkan header files'
  homepage 'https://www.khronos.org/vulkan'
  version '1.4.369'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/KhronosGroup/Vulkan-Headers.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ccb7b2bc470f7b5b84598876de949f8b8fef4288c6625aa76b8c1b4b94ff287b',
     armv7l: 'ccb7b2bc470f7b5b84598876de949f8b8fef4288c6625aa76b8c1b4b94ff287b',
     x86_64: '553e11d77cba46906601432d4ad5d945087bd35882c4e209f7d9029118c276b9'
  })
end
