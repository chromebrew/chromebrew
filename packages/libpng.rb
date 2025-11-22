require 'buildsystems/cmake'

class Libpng < CMake
  description 'libpng is the official PNG reference library.'
  homepage 'https://www.libpng.org/pub/png/libpng.html'
  version '1.6.51'
  license 'libpng2'
  compatibility 'all'
  source_url 'https://github.com/pnggroup/libpng.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f3e698f6782e7c02b3fd9d87ba5673dddb6d8316bb08673c901a3106b670438d',
     armv7l: 'f3e698f6782e7c02b3fd9d87ba5673dddb6d8316bb08673c901a3106b670438d',
       i686: 'db528c489fed3b2bfe901ada4c3bc7cbb44f818842c99fc07706208b5ebea780',
     x86_64: '0d4e1a2eee5813d54f70d738735ec7b7b5e84d312eedf95f7a287a6fd731fb7c'
  })

  depends_on 'zlib'
  depends_on 'glibc' # R

  gnome

  cmake_options '-DPNG_STATIC=OFF'
end
