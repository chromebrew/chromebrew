# Adapted from Arch Linux plutovg PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=plutovg

require 'buildsystems/meson'

class Plutovg < Meson
  description 'Tiny 2D vector graphics library in C'
  homepage 'https://github.com/sammycage/plutovg'
  version '1.3.1'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/sammycage/plutovg.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ef33367bf61b018b8361ab067260732d75550685abd51c8857e65b75f38c77c2',
     armv7l: 'ef33367bf61b018b8361ab067260732d75550685abd51c8857e65b75f38c77c2',
     x86_64: 'a8846feafd9729cb36028fea772950fdc504e62f76eacf95d9487f0bd9361857'
  })

  depends_on 'glibc' # R

  meson_options '-Dexamples=disabled \
                 -Dtests=disabled'
end
