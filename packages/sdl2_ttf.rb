# Adapted from Arch Linux sdl_ttf PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/sdl_ttf/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/cmake'

class Sdl2_ttf < CMake
  description 'A library that allows you to use TrueType fonts in your SDL applications'
  homepage 'https://www.libsdl.org/projects/SDL_ttf/'
  version '2.24.0'
  license 'zlib'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/libsdl-org/SDL_ttf.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5c6bb1ccbdf887008eb92f71afb92a1f3e99b44f8e512b2243805d2f7d5fb42d',
     armv7l: '5c6bb1ccbdf887008eb92f71afb92a1f3e99b44f8e512b2243805d2f7d5fb42d',
     x86_64: 'ae1ced676cf0fbb7c0b2c50e527f5a1bf99dd59432b1f63547f8d12812093b01'
  })

  depends_on 'freetype' # R
  depends_on 'glibc' # R
  depends_on 'sdl2' # R
  git_fetchtags
end
