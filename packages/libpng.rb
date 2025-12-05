require 'buildsystems/cmake'

class Libpng < CMake
  description 'libpng is the official PNG reference library.'
  homepage 'https://www.libpng.org/pub/png/libpng.html'
  version '1.6.52'
  license 'libpng2'
  compatibility 'all'
  source_url 'https://github.com/pnggroup/libpng.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3ad0fb2766d354c186aaf88ebcbe9add501594eee507b0598101ca1055baef33',
     armv7l: '3ad0fb2766d354c186aaf88ebcbe9add501594eee507b0598101ca1055baef33',
       i686: 'b5f86a98aae17725f36590e43f409686f20fdae55f70709cb077c7b12913b92c',
     x86_64: 'b9757a9b7641301868b38e5e1f2795e969b65689bcb679f6c7b6d399cc2685c1'
  })

  depends_on 'glibc' # R
  depends_on 'zlib'

  gnome

  cmake_options '-DPNG_STATIC=OFF'
end
