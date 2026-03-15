# Adapted from Arch Linux plutovg PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=plutovg

require 'buildsystems/meson'

class Plutovg < Meson
  description 'Tiny 2D vector graphics library in C'
  homepage 'https://github.com/sammycage/plutovg'
  version '1.3.2'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/sammycage/plutovg.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8565937159b8db6fe74228ce8fab549bd7958ca62b8785749229e586d4f6ae4d',
     armv7l: '8565937159b8db6fe74228ce8fab549bd7958ca62b8785749229e586d4f6ae4d',
     x86_64: '117e32962fb572947e1dc008191f1925e5563e88ebba105a27785463437aaa51'
  })

  depends_on 'glibc' # R

  meson_options '-Dexamples=disabled \
                 -Dtests=disabled'
end
