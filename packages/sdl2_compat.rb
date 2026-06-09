# Adapted from Arch Linux sdl2-compat PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/sdl2-compat/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/cmake'

class Sdl2_compat < CMake
  description 'An SDL2 compatibility layer that uses SDL3 behind the scenes'
  homepage 'https://github.com/libsdl-org/sdl2-compat'
  version '2.32.70'
  license 'zlib'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/libsdl-org/sdl2-compat.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '57def5ebea9e36874acb8779a499574f3a85bef14d36985573b7030efa1e1675',
     armv7l: '57def5ebea9e36874acb8779a499574f3a85bef14d36985573b7030efa1e1675',
     x86_64: 'bcef7b06372351c4be05adff98b8298cfdfddb45cbf434e896a4cf4ef9a54959'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'mesa' => :build
  depends_on 'sdl3' => :logical
end
