require 'buildsystems/cmake'

class Vulkan_headers < CMake
  description 'Vulkan header files'
  homepage 'https://www.khronos.org/vulkan'
  version '1.4.348'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/KhronosGroup/Vulkan-Headers.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '58ee626d3d400ef2f4f26b6eca3c8d5776e61ac5b9538ee6507edee21dba8d63',
     armv7l: '58ee626d3d400ef2f4f26b6eca3c8d5776e61ac5b9538ee6507edee21dba8d63',
     x86_64: 'c77de27eb13d60374ebb06e9db4ce2c755a4494b06c8095f3cb757ee140fc344'
  })
end
