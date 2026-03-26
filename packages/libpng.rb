require 'buildsystems/cmake'

class Libpng < CMake
  description 'libpng is the official PNG reference library.'
  homepage 'https://www.libpng.org/pub/png/libpng.html'
  version '1.6.56'
  license 'libpng2'
  compatibility 'all'
  source_url 'https://github.com/pnggroup/libpng.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '23136867801ce762ffb99dcaa78c6e29a6cac29947fa0b2f0d76d299e39d2df2',
     armv7l: '23136867801ce762ffb99dcaa78c6e29a6cac29947fa0b2f0d76d299e39d2df2',
       i686: 'b2af49a50105b9cc2d99074712e25cd115813396209f601b40e07aa2a92b427d',
     x86_64: '21704067f871c3e7605cd0bd4dfb558bcf7bbb569e8c405334761178582e5258'
  })

  depends_on 'glibc' => :library
  depends_on 'zlib' => :library

  gnome

  cmake_options '-DPNG_STATIC=OFF'
end
