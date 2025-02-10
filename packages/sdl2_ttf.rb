# Adapted from Arch Linux sdl_ttf PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/sdl_ttf/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/cmake'

class Sdl2_ttf < CMake
  description 'A library that allows you to use TrueType fonts in your SDL applications'
  homepage 'https://www.libsdl.org/projects/SDL_ttf/'
  version '2.22.0'
  license 'zlib'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/libsdl-org/SDL_ttf.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a0b3b7629948ab5af134c8f2e33340d0c95f46ebdd516193f44f66278433b7cf',
     armv7l: 'a0b3b7629948ab5af134c8f2e33340d0c95f46ebdd516193f44f66278433b7cf',
       i686: '6a1af809ce6d0fc507b1b857b8f0803c6aded4e816d3c454e4e59b0f5ed4acca',
     x86_64: '96673f6e91c2dddb26bb511cbdafcb6a1e853557fb545504d5e33b9ca9d1a588'
  })

  depends_on 'freetype' # R
  depends_on 'glibc' # R
  depends_on 'libsdl2' # R
  git_fetchtags
end
