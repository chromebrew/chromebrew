# Adapted from Arch Linux libgedit-gfls PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/libgedit-gfls/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/meson'

class Libgedit_gfls < Meson
  description 'A module dedicated to file loading and saving.'
  homepage 'https://gitlab.gnome.org/World/gedit/libgedit-gfls'
  version '0.1.0'
  license 'LGPL-3.0-or-later'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/World/gedit/libgedit-gfls.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5a38524bfffb0acba0ecb60c5c34fbee3d0fe2453537d6830801b317afcff632',
     armv7l: '5a38524bfffb0acba0ecb60c5c34fbee3d0fe2453537d6830801b317afcff632',
     x86_64: 'fc3dbebc7df1faef769ca9ec8206520c4a8d2ee2cd111b019ab6e5b8d7670778'
  })

  meson_options '-Dgtk_doc=false'
end
