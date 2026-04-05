# Adapted from Arch Linux sdl2-compat PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/sdl2-compat/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/cmake'

class Sdl2_compat < CMake
  description 'An SDL2 compatibility layer that uses SDL3 behind the scenes'
  homepage 'https://github.com/libsdl-org/sdl2-compat'
  version '2.32.66'
  license 'zlib'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/libsdl-org/sdl2-compat.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f5b252d3900d9b84003ec35751452e7a18a57e6de2d27b3ee845e1f001527256',
     armv7l: 'f5b252d3900d9b84003ec35751452e7a18a57e6de2d27b3ee845e1f001527256',
     x86_64: '7e8bad62d022c932d6a47a7ef494d4985cfb57c1a134884b31047a546f7663fc'
  })

  depends_on 'glibc' => :library
  depends_on 'mesa' => :build
  depends_on 'sdl3' => :logical
end
