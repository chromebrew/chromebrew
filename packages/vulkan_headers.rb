require 'buildsystems/cmake'

class Vulkan_headers < CMake
  description 'Vulkan header files'
  homepage 'https://github.com/KhronosGroup/Vulkan-Headers'
  version '1.4.303'
  license 'Apache-2.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/KhronosGroup/Vulkan-Headers.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3a4d72912cb12489e72300acaca66bb45c65247a5fc17b548f4b70eb9bd20bd8',
     armv7l: '3a4d72912cb12489e72300acaca66bb45c65247a5fc17b548f4b70eb9bd20bd8',
     x86_64: '9fff78c1efbfe537ce3d0eb437d902bb09a986ab5fc1c035c4edab07c7aec78a'
  })
end
