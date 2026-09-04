require 'buildsystems/cmake'

class Sdl3_image < CMake
  description 'SDL3_image is an image loading library that is used with the SDL2 library.'
  homepage 'https://github.com/libsdl-org/SDL_image'
  version '3.4.6'
  license 'zlib'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/libsdl-org/SDL_image.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fa886baa2de144035bc8892eb9b6876a300dbf3153035e4dcf3eb155daefd4f4',
     armv7l: 'fa886baa2de144035bc8892eb9b6876a300dbf3153035e4dcf3eb155daefd4f4',
     x86_64: '4b4b5cd8353b0c9fba23d940348e5b1697e428674a981ae044198c54848739c5'
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
