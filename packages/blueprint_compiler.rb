# Adapted from Arch Linux blueprint-compiler PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/blueprint-compiler/trunk/PKGBUILD

require 'buildsystems/meson'

class Blueprint_compiler < Meson
  description 'A markup language for GTK user interfaces'
  homepage 'https://gitlab.gnome.org/GNOME/blueprint-compiler'
  version '0.19.0'
  license 'LGPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/blueprint-compiler.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '663d47197654ed242479e989bf77674e2b771bea19bed49f6e73f14cc03860da',
     armv7l: '663d47197654ed242479e989bf77674e2b771bea19bed49f6e73f14cc03860da',
     x86_64: '87785fad35e13182fa1b3927413fcfa365ec7dc50fe8c6da86c95662a8090c44'
  })

  depends_on 'py3_pygobject' # R
end
