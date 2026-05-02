# Adapted from Arch Linux sdl2-compat PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/sdl2-compat/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/cmake'

class Sdl2_compat < CMake
  description 'An SDL2 compatibility layer that uses SDL3 behind the scenes'
  homepage 'https://github.com/libsdl-org/sdl2-compat'
  version '2.32.68'
  license 'zlib'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/libsdl-org/sdl2-compat.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b68823b2a5ec2abdace3fe303d7cf7fbe363510f8bea30fcd258191dd765ef71',
     armv7l: 'b68823b2a5ec2abdace3fe303d7cf7fbe363510f8bea30fcd258191dd765ef71',
     x86_64: 'e872d75a9ec7b32242c11833098561e55b4863c862b24aa233fc65764e600a1c'
  })

  depends_on 'glibc' => :library
  depends_on 'mesa' => :build
  depends_on 'sdl3' => :logical
end
