# Adapted from Arch Linux sdl_ttf PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/sdl_ttf/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/cmake'

class Sdl3_ttf < CMake
  description 'A library that allows you to use TrueType fonts in your SDL applications'
  homepage 'https://www.libsdl.org/projects/SDL_ttf/'
  @_ver = '7d62ee195e32180b874c97a07df4080712b467b6'
  version "3.0.0-#{@_ver[0..6]}"
  license 'Zlib'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/libsdl-org/SDL_ttf.git'
  git_hashtag @_ver
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a1a8d61d588fd8219773275fb480c6b787f814e509df65b7d54b19c6e396e67a',
     armv7l: 'a1a8d61d588fd8219773275fb480c6b787f814e509df65b7d54b19c6e396e67a',
       i686: '6a1af809ce6d0fc507b1b857b8f0803c6aded4e816d3c454e4e59b0f5ed4acca',
     x86_64: '1acd7b53dbfd43f76bef150cf90e2e841f58e2320c7dc9c6a0026d24eecb3ac8'
  })

  depends_on 'freetype' # R
  depends_on 'glibc' # R
  depends_on 'libsdl2' # R
  depends_on 'sdl3' # R
  git_fetchtags
end
