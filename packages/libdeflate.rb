require 'buildsystems/cmake'

class Libdeflate < CMake
  description 'Heavily optimized library for DEFLATE compression and decompression'
  homepage 'https://github.com/ebiggers/libdeflate/'
  version '1.25'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ebiggers/libdeflate.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f792cf546a34679f1adb200c6168d4afcf15dd6c63b82e69bff4c7332f0a4418',
     armv7l: 'f792cf546a34679f1adb200c6168d4afcf15dd6c63b82e69bff4c7332f0a4418',
       i686: '3ba0bdf0998f32a6ad288ed00eff2a06460634bc49f5e4844a7de45a904f7eba',
     x86_64: '411f9a08e70d77522cee749314638870d2c4379dd744a622e017887f6fee5adf'
  })

  depends_on 'glibc' # R
end
