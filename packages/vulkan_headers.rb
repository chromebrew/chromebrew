require 'buildsystems/cmake'

class Vulkan_headers < CMake
  description 'Vulkan header files'
  homepage 'https://www.khronos.org/vulkan'
  version '1.4.368'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/KhronosGroup/Vulkan-Headers.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7e4e23321b770e018b246bc66e85fa0443fae6196ade89bd6af8486ee351d4a3',
     armv7l: '7e4e23321b770e018b246bc66e85fa0443fae6196ade89bd6af8486ee351d4a3',
     x86_64: 'd5ac26cb1a42e0ad52142564dbd8e27483da0ccb09e2c07cd23568b4ac0c2923'
  })
end
