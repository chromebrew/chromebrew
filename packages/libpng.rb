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
    aarch64: '6a8dc1970e5fa94081fc14e50ea0ab060ec4af3fe6a6b77b3ff49e1be02da85a',
     armv7l: '6a8dc1970e5fa94081fc14e50ea0ab060ec4af3fe6a6b77b3ff49e1be02da85a',
       i686: 'f8b319b2d00dc8771561b140a4d2f9044b8bb2baf5ea714eda06058526f7814b',
     x86_64: '57168fc3f94d9652220b9fc27d58b1d410c4bb5938e9ef4e39862fe8d545ee20'
  })

  depends_on 'glibc' # R
  depends_on 'zlib'

  gnome

  cmake_options '-DPNG_STATIC=OFF'
end
