require 'buildsystems/cmake'

class Vulkan_headers < CMake
  description 'Vulkan header files'
  homepage 'https://github.com/KhronosGroup/Vulkan-Headers'
  version '1.4.325'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/KhronosGroup/Vulkan-Headers.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1392834ace6df8cdb9a0bd63881a4a4d602eec6fa204c1ef256a3dc98959047c',
     armv7l: '1392834ace6df8cdb9a0bd63881a4a4d602eec6fa204c1ef256a3dc98959047c',
     x86_64: 'b33b898a0ce69abb57138d302f92602022e67a03c7bae98b50fd8f30362bc040'
  })
end
