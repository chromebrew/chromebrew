# Adapted from Arch Linux libspelling PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/libspelling/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/meson'

class Libspelling < Meson
  description 'Spellcheck library for GTK 4'
  homepage 'https://gitlab.gnome.org/GNOME/libspelling'
  version '0.4.9'
  license 'LGPL-2.1-or-later'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/libspelling.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c65dfe49ae68576c48d8763e0ba7d13b582ed3412afaa7bf5650ce3b734127d8',
     armv7l: 'c65dfe49ae68576c48d8763e0ba7d13b582ed3412afaa7bf5650ce3b734127d8',
     x86_64: '385f3cb049c16fa88a52b54ae61f73b5fb8167413aab3edee0040d832a6c2d97'
  })

  depends_on 'enchant' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gtk4' # R
  depends_on 'gtksourceview_5' # R
  depends_on 'icu4c' # R
  depends_on 'pango' # R

  meson_options '-D{docs,sysprof}=false -Dintrospection=disabled'
end
