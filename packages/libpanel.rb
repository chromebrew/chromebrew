# Adapted from Arch Linux libpanel PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=libpanel

require 'buildsystems/meson'

class Libpanel < Meson
  description 'A dock/panel library for GTK 4'
  homepage 'https://gitlab.gnome.org/GNOME/libpanel'
  version '1.6.0'
  license 'GPL3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/libpanel.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e1d7793ff74bfb7434dd2ab8be7cd4f47ec7fa5f2516f571b47abbaa084b0416',
     armv7l: 'e1d7793ff74bfb7434dd2ab8be7cd4f47ec7fa5f2516f571b47abbaa084b0416',
     x86_64: '22631b569c564403c645f5e4bf16e857d029a2a301d7b150cf5bf1161c12c2aa'
  })

  depends_on 'cairo' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
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
