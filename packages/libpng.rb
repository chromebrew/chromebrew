require 'buildsystems/cmake'

class Libpng < CMake
  description 'libpng is the official PNG reference library.'
  homepage 'https://www.libpng.org/pub/png/libpng.html'
  version '1.6.55'
  license 'libpng2'
  compatibility 'all'
  source_url 'https://github.com/pnggroup/libpng.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b6471a07407d111d914a645f2c925c1b2bbbdadb4d1525ac038f4b4c50c01e52',
     armv7l: 'b6471a07407d111d914a645f2c925c1b2bbbdadb4d1525ac038f4b4c50c01e52',
       i686: '29fa8cfccd5c4b34c72783168c402b27796a0f4d2261914490f7bfdec50c42ae',
     x86_64: 'de99af9a941c8d5334c7009892c86f0544967515f2f53c1e0f60101216009592'
  })

  depends_on 'glibc' # R
  depends_on 'zlib' # R

  gnome

  cmake_options '-DPNG_STATIC=OFF'
end
