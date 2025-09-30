require 'buildsystems/cmake'

class Sdl3_image < CMake
  description 'SDL3_image is an image loading library that is used with the SDL2 library.'
  homepage 'https://github.com/libsdl-org/SDL_image'
  version '3.2.4'
  license 'zlib'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/libsdl-org/SDL_image.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '32763b2ef38dbe572dc727f840167283c3e264e649f3774ae7202c47fdf42834',
     armv7l: '32763b2ef38dbe572dc727f840167283c3e264e649f3774ae7202c47fdf42834',
     x86_64: '45c73a636295549a8f46de09438355ae2be606c15080ca830c26e30aa5dc281c'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libavif' => :build
  depends_on 'libjpeg_turbo' => :build
  depends_on 'libjxl' => :build
  depends_on 'libpng' => :build
  depends_on 'libtiff' => :build
  depends_on 'libwebp' => :build
  depends_on 'sdl3' # R
end
