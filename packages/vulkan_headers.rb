require 'buildsystems/cmake'

class Vulkan_headers < CMake
  description 'Vulkan header files'
  homepage 'https://github.com/KhronosGroup/Vulkan-Headers'
  version '1.3.278'
  license 'Apache-2.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/KhronosGroup/Vulkan-Headers.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '914fdbdca75bbccae537790a03450ae3ad1c97b38f8d08d89f0276f90ebae87d',
     armv7l: '914fdbdca75bbccae537790a03450ae3ad1c97b38f8d08d89f0276f90ebae87d',
     x86_64: '94a8d53d908a56fe1b4a111fa98dc1a8c949aa64466055d272edd3b5ebd2baec'
  })
end
