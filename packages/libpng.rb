require 'buildsystems/cmake'

class Libpng < CMake
  description 'libpng is the official PNG reference library.'
  homepage 'https://www.libpng.org/pub/png/libpng.html'
  version '1.6.53'
  license 'libpng2'
  compatibility 'all'
  source_url 'https://github.com/pnggroup/libpng.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '266c802632ad7f5ae12715a3f8261a85d3091da369f02345f448747f84d00bc4',
     armv7l: '266c802632ad7f5ae12715a3f8261a85d3091da369f02345f448747f84d00bc4',
       i686: 'c71f7e49f759f5a7efcd1fe65523e4896d6180dd3bd8a4b57589fee2a88fe29e',
     x86_64: '0105ff040402004dc3ff7ce9bf6228e8da9515547d804edc36ac7fb3c3114b5c'
  })

  depends_on 'glibc' # R
  depends_on 'zlib'

  gnome

  cmake_options '-DPNG_STATIC=OFF'
end
