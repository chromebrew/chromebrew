require 'buildsystems/cmake'

class Vulkan_headers < CMake
  description 'Vulkan header files'
  homepage 'https://www.khronos.org/vulkan'
  version '1.4.355'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/KhronosGroup/Vulkan-Headers.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fdd5739469b6493ac47052e2e3d825e7dfea40e7884e29f99fc31562b46a8ab3',
     armv7l: 'fdd5739469b6493ac47052e2e3d825e7dfea40e7884e29f99fc31562b46a8ab3',
     x86_64: '79ba01d822ec8dc8a357867a609631ce1d77c81631e3214f17dbaa02d9a53150'
  })
end
