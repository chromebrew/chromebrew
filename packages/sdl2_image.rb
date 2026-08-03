require 'buildsystems/cmake'

class Sdl2_image < CMake
  description 'SDL2_image is an image loading library that is used with the SDL2 library.'
  homepage 'https://github.com/libsdl-org/SDL_image'
  version '2.8.12'
  license 'zlib'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/libsdl-org/SDL_image.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '562e4bb8e568a81837536605d4954013f0880b33d80080245b10ffd464796cbe',
     armv7l: '562e4bb8e568a81837536605d4954013f0880b33d80080245b10ffd464796cbe',
     x86_64: 'd3d1dcbd043e4583f90e6185a940183c4356a2794cbb24d39aeba96dfecc26c9'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libavif' => :build
  depends_on 'libjpeg_turbo' => :build
  depends_on 'libpng' => :build
  depends_on 'libtiff' => :build
  depends_on 'libwebp' => :build
  depends_on 'sdl2' => :library
  depends_on 'sdl2_compat' => :library
end
