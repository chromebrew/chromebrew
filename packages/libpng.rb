require 'buildsystems/cmake'

class Libpng < CMake
  description 'libpng is the official PNG reference library.'
  homepage 'https://www.libpng.org/pub/png/libpng.html'
  version '1.6.58'
  license 'libpng2'
  compatibility 'all'
  source_url 'https://github.com/pnggroup/libpng.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '57d7f98f8cc453ce9be503bfa94b4f20cdc37bf354d93740be26846658dbe89e',
     armv7l: '57d7f98f8cc453ce9be503bfa94b4f20cdc37bf354d93740be26846658dbe89e',
       i686: '4f719aaf2d0626832ec34b7a910ff28784aac24ffdf1dc67be452fb5ad9273aa',
     x86_64: 'c30993dc7d71d8ccacf2610925d185607de93b59b66f9b4d911bb10247bd9c06'
  })

  depends_on 'glibc' => :library
  depends_on 'zlib' => :library

  gnome

  cmake_options '-DPNG_STATIC=OFF'
end
