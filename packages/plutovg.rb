# Adapted from Arch Linux plutovg PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=plutovg

require 'buildsystems/meson'

class Plutovg < Meson
  description 'Tiny 2D vector graphics library in C'
  homepage 'https://github.com/sammycage/plutovg'
  version '1.3.3'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/sammycage/plutovg.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2898d3370a304bda26d0c7f63e26f1f53f9fc9c55e4f765fb02ffe899c778546',
     armv7l: '2898d3370a304bda26d0c7f63e26f1f53f9fc9c55e4f765fb02ffe899c778546',
     x86_64: 'd14e5da6636e2fc1ca5195ee2e830efa3a0948474477ae24537def753e4ae67f'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  meson_options '-Dexamples=disabled \
                 -Dtests=disabled'
end
