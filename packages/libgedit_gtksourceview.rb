# Adapted from Arch Linux libgedit-gtksourceview PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=libgedit-gtksourceview

require 'buildsystems/meson'

class Libgedit_gtksourceview < Meson
  description 'A library that extends GtkTextView, the standard GTK '
  homepage 'https://gedit-technology.github.io'
  version '299.0.5'
  license 'LGPL2.1'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/gedit-technology/libgedit-gtksourceview.git'
  git_hashtag version
  binary_compression 'tar.zst'

  meson_options '-Dgtk_doc=false'
end
