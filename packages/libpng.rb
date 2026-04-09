require 'buildsystems/cmake'

class Libpng < CMake
  description 'libpng is the official PNG reference library.'
  homepage 'https://www.libpng.org/pub/png/libpng.html'
  version '1.6.57'
  license 'libpng2'
  compatibility 'all'
  source_url 'https://github.com/pnggroup/libpng.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd81e2446f0984e117df528a9c865431306aba7ad29a5c13c94015e5ea9bede4d',
     armv7l: 'd81e2446f0984e117df528a9c865431306aba7ad29a5c13c94015e5ea9bede4d',
       i686: 'f69a128b5d6408e27a7f0644be6bb17a1cc9c0701bb2c244599a37ff47df0b60',
     x86_64: '28d60a855eccbb8be7037828c6645401e0ad36411d4bb80eb59b9636e064861b'
  })

  depends_on 'glibc' => :library
  depends_on 'zlib' => :library

  gnome

  cmake_options '-DPNG_STATIC=OFF'
end
