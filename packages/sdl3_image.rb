require 'buildsystems/cmake'

class Sdl3_image < CMake
  description 'SDL3_image is an image loading library that is used with the SDL2 library.'
  homepage 'https://github.com/libsdl-org/SDL_image'
  version '3.4.8'
  license 'zlib'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/libsdl-org/SDL_image.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5d0604d91744b09cac2b0e5ce020714cfb8e7f6d193f30c4d1a029f7863323c6',
     armv7l: '5d0604d91744b09cac2b0e5ce020714cfb8e7f6d193f30c4d1a029f7863323c6',
     x86_64: '16b575e6d0c45e03d30a43715f748c9057e007e1b96f82ab5e875653b79521f2'
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
