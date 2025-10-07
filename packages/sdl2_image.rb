require 'buildsystems/cmake'

class Sdl2_image < CMake
  description 'SDL2_image is an image loading library that is used with the SDL2 library.'
  homepage 'https://github.com/libsdl-org/SDL_image'
  version '2.8.8'
  license 'zlib'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/libsdl-org/SDL_image.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '66d34caf9064dabc64c11648c4e6810edc2347fb1b7d7f2ddfb6714d635d2708',
     armv7l: '66d34caf9064dabc64c11648c4e6810edc2347fb1b7d7f2ddfb6714d635d2708',
     x86_64: '3243a9ec382c8e15f8aa72713e7728975971a32ca78afb785362fe70617aa24f'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libavif' => :build
  depends_on 'libjpeg_turbo' => :build
  depends_on 'libpng' => :build
  depends_on 'libtiff' => :build
  depends_on 'libwebp' => :build
  depends_on 'sdl2' # R
end
