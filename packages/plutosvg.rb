# Adapted from Arch Linux plutosvg PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=plutosvg

require 'buildsystems/meson'

class Plutosvg < Meson
  description 'Tiny SVG rendering library in C'
  homepage 'https://github.com/sammycage/plutosvg'
  version '0.0.8'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/sammycage/plutosvg.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '189cbe539c74e4afead95eb09174c74d31a2d959ee4a34774c9097637ad476fc',
     armv7l: '189cbe539c74e4afead95eb09174c74d31a2d959ee4a34774c9097637ad476fc',
     x86_64: '64dee5fc75b71355d4bdb0db48090fe6035ad6f2578abdc97f9296299955c2c3'
  })

  depends_on 'freetype' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'plutovg' => :library

  meson_options '-Dfreetype=enabled \
                 -Dexamples=disabled \
                 -Dtests=disabled'
end
