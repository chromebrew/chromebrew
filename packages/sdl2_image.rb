require 'buildsystems/autotools'

class Sdl2_image < Autotools
  description 'SDL2_image is an image loading library that is used with the SDL2 library.'
  homepage 'https://github.com/libsdl-org/SDL_image'
  version '2.8.2'
  license 'ZLIB'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/libsdl-org/SDL_image.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1d0d60b10c863b665f400c8e65b89dc038c38ccfd64ccd9dd19e0ea017094260',
     armv7l: '1d0d60b10c863b665f400c8e65b89dc038c38ccfd64ccd9dd19e0ea017094260',
     x86_64: '2cd54c0f5fd71e02e7c0d5ebe9643f87e18fc239b8233db062ab1e906ccd60cb'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libavif' => :build
  depends_on 'libjpeg_turbo' => :build
  depends_on 'libpng' => :build
  depends_on 'libsdl2' # R
  depends_on 'libtiff' => :build
  depends_on 'libwebp' => :build
end
