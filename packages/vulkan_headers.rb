require 'buildsystems/cmake'

class Vulkan_headers < CMake
  description 'Vulkan header files'
  homepage 'https://github.com/KhronosGroup/Vulkan-Headers'
  version '1.3.283'
  license 'Apache-2.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/KhronosGroup/Vulkan-Headers.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c9e424ded8d55000b959346e50d3524402e154a589944da59967ab80f7f4fdff',
     armv7l: 'c9e424ded8d55000b959346e50d3524402e154a589944da59967ab80f7f4fdff',
     x86_64: '99ddd5313f3e3ff1c166fadd0ed4acfb6d3685c273ae2ae8c3e87d5de9c98137'
  })
end
