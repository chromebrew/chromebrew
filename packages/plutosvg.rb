# Adapted from Arch Linux plutosvg PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=plutosvg

require 'buildsystems/meson'

class Plutosvg < Meson
  description 'Tiny SVG rendering library in C'
  homepage 'https://github.com/sammycage/plutosvg'
  version '0.0.7'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/sammycage/plutosvg.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6e634c8138998104ed3b153f225bb34f06baa71c145751e808f4843087250feb',
     armv7l: '6e634c8138998104ed3b153f225bb34f06baa71c145751e808f4843087250feb',
     x86_64: '03db96961450d5e3f4240fa37fd3d625a983a66a70561b7bbde159d0ed99e8de'
  })

  depends_on 'freetype' # R
  depends_on 'glibc' # R
  depends_on 'plutovg' # R

  meson_options '-Dfreetype=enabled \
                 -Dexamples=disabled \
                 -Dtests=disabled'
end
