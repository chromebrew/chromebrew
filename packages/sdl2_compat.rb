# Adapted from Arch Linux sdl2-compat PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/sdl2-compat/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/cmake'

class Sdl2_compat < CMake
  description 'An SDL2 compatibility layer that uses SDL3 behind the scenes'
  homepage 'https://github.com/libsdl-org/sdl2-compat'
  version '2.32.74'
  license 'zlib'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/libsdl-org/sdl2-compat.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '498a74cd37bf9cfcfa96f2ca9ebff1127871cceb2baa962adce2163f9dae74f1',
     armv7l: '498a74cd37bf9cfcfa96f2ca9ebff1127871cceb2baa962adce2163f9dae74f1',
     x86_64: '58c1a0d72f63de1c59cb7a6f40326002ce2635de9bf980cf41394ac6a4a28365'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'mesa' => :build
  depends_on 'sdl3' => :logical
end
