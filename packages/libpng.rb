require 'buildsystems/cmake'

class Libpng < CMake
  description 'libpng is the official PNG reference library.'
  homepage 'https://www.libpng.org/pub/png/libpng.html'
  version '1.6.59'
  license 'libpng2'
  compatibility 'all'
  source_url 'https://github.com/pnggroup/libpng.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5dccca895c960ed0ffdcd1e39b64ee94f6a704ec5eb98e663cd358665a239a96',
     armv7l: '5dccca895c960ed0ffdcd1e39b64ee94f6a704ec5eb98e663cd358665a239a96',
       i686: '4db53862c0ce972b15f3f18e20621603b20773872783d4e4d333b95f6e46e255',
     x86_64: '6ec6d82247e4d0a52853b4bd512d35224e6d9bbf09d561cc1458f19021cc74ad'
  })

  depends_on 'glibc' => :library
  depends_on 'zlib' => :library

  gnome

  cmake_options '-DPNG_STATIC=OFF'
end
