require 'buildsystems/cmake'

class Libpng < CMake
  description 'libpng is the official PNG reference library.'
  homepage 'https://www.libpng.org/pub/png/libpng.html'
  version '1.6.50'
  license 'libpng2'
  compatibility 'all'
  source_url 'https://github.com/pnggroup/libpng.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ea5f9f73bd232972fdbf3c6d3d14da99c03af1b6d4e547e6faf59ad7ad73c3e2',
     armv7l: 'ea5f9f73bd232972fdbf3c6d3d14da99c03af1b6d4e547e6faf59ad7ad73c3e2',
       i686: '209b1a2196ce57bf7d6fffc53ddb30825ec80278e105e07d09cc19c1ad0f6571',
     x86_64: 'cc55bf8441e29ac7bcfb0b80d7903cbb5816df85ffd052376de6396b18c80cf5'
  })

  depends_on 'zlib'
  depends_on 'glibc' # R

  gnome

  cmake_options '-DPNG_STATIC=OFF'
end
