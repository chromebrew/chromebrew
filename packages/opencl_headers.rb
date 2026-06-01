require 'buildsystems/cmake'

class Opencl_headers < CMake
  description 'OpenCL header files'
  homepage 'https://github.com/KhronosGroup/OpenCL-Headers'
  version '2026.05.29'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/OpenCL-Headers.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '36148ca22d9d64e32485a61e8b5b378ae0f8b72e08ab7b2e2030bec00058fed3',
     armv7l: '36148ca22d9d64e32485a61e8b5b378ae0f8b72e08ab7b2e2030bec00058fed3',
       i686: '876fa729669cb4b0b03f65aa5d5567cde6cd75c03bbba6df1cf5cf0a2c31ad08',
     x86_64: '36e36e21b35cf17676625f7bd88d595ef485a17ca17dbc95fcda00c3f0f59bc3'
  })
end
