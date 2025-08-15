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
    aarch64: 'fb39dfbac8e29598bf0adf90b336a06351f48810dd505a3806d0c856ab5d7596',
     armv7l: 'fb39dfbac8e29598bf0adf90b336a06351f48810dd505a3806d0c856ab5d7596',
     x86_64: 'afbdfbcd384d90302f5abb2d9a335f82a5958a5058eb1c358e160ea571bd9c6a'
  })
end
