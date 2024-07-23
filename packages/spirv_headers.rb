require 'buildsystems/cmake'

class Spirv_headers < CMake
  homepage 'https://github.com/KhronosGroup/SPIRV-Headers'
  description 'SPIR-V Headers'
  version '1.3.283.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/SPIRV-Headers.git'
  git_hashtag "vulkan-sdk-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '56b65ee42413a4082ea307f966f7f210b2122bc7dbb1affcefc9d2d0522108e8',
     armv7l: '56b65ee42413a4082ea307f966f7f210b2122bc7dbb1affcefc9d2d0522108e8',
       i686: 'e504e50da7ded4996fafb8e0efe5df5d55b717a9c3707d9aaed09c9601f7548c',
     x86_64: 'ad032337d87144f12d3a16cfcd5948cc5a33c6b330cd6353d7bd9b83245403f3'
  })
end
