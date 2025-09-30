# Adapted from Arch Linux sdl2-compat PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/sdl2-compat/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/cmake'

class Sdl2_compat < CMake
  description 'An SDL2 compatibility layer that uses SDL3 behind the scenes'
  homepage 'https://github.com/libsdl-org/sdl2-compat'
  version '2.32.56'
  license 'zlib'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/libsdl-org/sdl2-compat.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0c91a49593c744598cd9d86797030e4e9bd9ad552ea735f7d00b21d417bf6707',
     armv7l: '0c91a49593c744598cd9d86797030e4e9bd9ad552ea735f7d00b21d417bf6707',
     x86_64: '86b777d0bf56c427de352e393c273e6a51c04c6f173cfa2587da10b0d792984a'
  })

  depends_on 'glibc' # R
  depends_on 'mesa' => :build
  depends_on 'sdl3' # L
end
