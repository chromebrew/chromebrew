# Adapted from Arch Linux libpanel PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=libpanel

require 'buildsystems/meson'

class Libpanel < Meson
  description 'A dock/panel library for GTK 4'
  homepage 'https://gitlab.gnome.org/GNOME/libpanel'
  version '1.10.2'
  license 'GPL3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/libpanel.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'af4dabe44ccc020bdb9b5e1c1edae19e3d800a04923b4e54aa8c6a0ec09c4e2f',
     armv7l: 'af4dabe44ccc020bdb9b5e1c1edae19e3d800a04923b4e54aa8c6a0ec09c4e2f',
     x86_64: 'a823b50842829555e96f24728902e53ff219a2acb28ab2308701e7a3e3df9d7b'
  })

  depends_on 'cairo' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'graphene' # R
  depends_on 'gtk4' # R
  depends_on 'harfbuzz' # R
  depends_on 'libadwaita' # R
  depends_on 'py3_gi_docgen' => :build
  depends_on 'py3_smartypants' => :build
  depends_on 'vala' => :build

  gnome
end
