# Adapted from Arch Linux sdl2-compat PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/sdl2-compat/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/cmake'

class Sdl2_compat < CMake
  description 'An SDL2 compatibility layer that uses SDL3 behind the scenes'
  homepage 'https://github.com/libsdl-org/sdl2-compat'
  version '2.32.72'
  license 'zlib'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/libsdl-org/sdl2-compat.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '73f634c51d063bd102f61ab5b81739d7f92e16603fe7855e8b7466e22cd12f27',
     armv7l: '73f634c51d063bd102f61ab5b81739d7f92e16603fe7855e8b7466e22cd12f27',
     x86_64: '9da8c00019eae8ca52ae7222d4ab7e6e960869d6a0012f8c95f1eb562a5a1649'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'mesa' => :build
  depends_on 'sdl3' => :logical
end
