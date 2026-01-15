require 'buildsystems/cmake'

class Libpng < CMake
  description 'libpng is the official PNG reference library.'
  homepage 'https://www.libpng.org/pub/png/libpng.html'
  version '1.6.54'
  license 'libpng2'
  compatibility 'all'
  source_url 'https://github.com/pnggroup/libpng.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '928b4ca99f5cb89f47975dc24c252dea2f37b6d24b114f5671ce3421ab33bc6d',
     armv7l: '928b4ca99f5cb89f47975dc24c252dea2f37b6d24b114f5671ce3421ab33bc6d',
       i686: 'a7e06a3637660bb00ec02c8150c6447156ca10b1812c94b1cdeb63470b9f3539',
     x86_64: '29c710c4dde4d6f9af3695ff59751d9cbe57d2c5489de6b7fb92e704a0ad72a5'
  })

  depends_on 'glibc' # R
  depends_on 'zlib'

  gnome

  cmake_options '-DPNG_STATIC=OFF'
end
