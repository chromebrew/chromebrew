require 'buildsystems/cmake'

class Vulkan_headers < CMake
  description 'Vulkan header files'
  homepage 'https://www.khronos.org/vulkan'
  version '1.4.357'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/KhronosGroup/Vulkan-Headers.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0b83328ff8123f1d7c46ff6fafd4a076333f3280b7095fe4b7fadb0c0b281830',
     armv7l: '0b83328ff8123f1d7c46ff6fafd4a076333f3280b7095fe4b7fadb0c0b281830',
     x86_64: '19c4129581b18d9a8bab7e37c3353e950204cb55e9801fd1885fdcc53cbfd775'
  })
end
