require 'buildsystems/cmake'

class Vulkan_headers < CMake
  description 'Vulkan header files'
  homepage 'https://github.com/KhronosGroup/Vulkan-Headers'
  version '1.3.275'
  license 'Apache-2.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/KhronosGroup/Vulkan-Headers.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4851f37ec409578b77499eb90dc0ba9676dc0c19f19d2427d19f6fc806070eaf',
     armv7l: '4851f37ec409578b77499eb90dc0ba9676dc0c19f19d2427d19f6fc806070eaf',
     x86_64: 'c62787530bfa51c7fca6019653418ce80729e93f686b09aa441eee084ac08c69'
  })
end
