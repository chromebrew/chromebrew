# Adapted from Arch Linux libgedit-gfls PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/libgedit-gfls/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/meson'

class Libgedit_gfls < Meson
  description 'A module dedicated to file loading and saving.'
  homepage 'https://gitlab.gnome.org/World/gedit/libgedit-gfls'
  version '0.3.0'
  license 'LGPL-3.0-or-later'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/World/gedit/libgedit-gfls.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f55c6cfe11d52ef37e4f2e58a64fc721c0d6176245e44356de5785b9cea5092f',
     armv7l: 'f55c6cfe11d52ef37e4f2e58a64fc721c0d6176245e44356de5785b9cea5092f',
     x86_64: '19e7d404fd0f75be23e179a2db1b7468dbe6b10ad86161eb0f6f1f6d5bc6576c'
  })

  depends_on 'glib' # R
  depends_on 'glibc' # R

  meson_options '-Dgtk_doc=false'
end
