# Adapted from Arch Linux adwaita-fonts PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/adwaita-fonts/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/meson'

class Adwaita_fonts < Meson
  description 'The typefaces for GNOME'
  homepage 'https://gitlab.gnome.org/GNOME/adwaita-fonts'
  version '48.2'
  license 'GPL-3.0-or-later'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/adwaita-fonts.git'
  git_hashtag version
  binary_compression 'tar.zst'

  gnome
end
