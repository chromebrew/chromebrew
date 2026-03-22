# Adapted from Arch Linux sdl2-compat PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/sdl2-compat/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/cmake'

class Sdl2_compat < CMake
  description 'An SDL2 compatibility layer that uses SDL3 behind the scenes'
  homepage 'https://github.com/libsdl-org/sdl2-compat'
  version '2.32.64'
  license 'zlib'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/libsdl-org/sdl2-compat.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7d3f55fb10798ded67034c244d1e06eebf88650eb4e2fa0b8471a3cf373577ef',
     armv7l: '7d3f55fb10798ded67034c244d1e06eebf88650eb4e2fa0b8471a3cf373577ef',
     x86_64: 'f10ddb56780218a37398463979e9bd9025108a5a5f6544d4c683955554c931d4'
  })

  depends_on 'glibc' => :library
  depends_on 'mesa' => :build
  depends_on 'sdl3' => :logical
end
