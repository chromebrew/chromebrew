# Adapted from Arch Linux sdl_ttf PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/sdl_ttf/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/cmake'

class Sdl3_ttf < CMake
  description 'A library that allows you to use TrueType fonts in your SDL applications'
  homepage 'https://www.libsdl.org/projects/SDL_ttf/'
  version '3.2.2'
  license 'Zlib'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/libsdl-org/SDL_ttf.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e4ec49ff80df35e315ba51b8dc594751264a87c7f803238a6299e5bf7315bd2c',
     armv7l: 'e4ec49ff80df35e315ba51b8dc594751264a87c7f803238a6299e5bf7315bd2c',
     x86_64: '1fff7410f9462af21befa3c44cecc8a9254671c03ba23d6044f310d0f0b0885d'
  })

  depends_on 'freetype' # R
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R
  depends_on 'plutosvg' # R
  depends_on 'plutovg' # R
  depends_on 'sdl3' # R
  git_fetchtags
end
