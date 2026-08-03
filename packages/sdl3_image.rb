require 'buildsystems/cmake'

class Sdl3_image < CMake
  description 'SDL3_image is an image loading library that is used with the SDL2 library.'
  homepage 'https://github.com/libsdl-org/SDL_image'
  version '3.4.4'
  license 'zlib'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/libsdl-org/SDL_image.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '05a4129c6cceee96765486c45f97ac25dd406331d2a212cabecea4430b8fecf7',
     armv7l: '05a4129c6cceee96765486c45f97ac25dd406331d2a212cabecea4430b8fecf7',
     x86_64: '4dd5bc6aaa28ae8e7aa41b71488d4328879a98d25732f9ef7588a7ed7ea783bb'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libavif' => :build
  depends_on 'libjpeg_turbo' => :build
  depends_on 'libjxl' => :build
  depends_on 'libpng' => :build
  depends_on 'libtiff' => :build
  depends_on 'libwebp' => :build
  depends_on 'sdl3' => :library
end
