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

  binary_sha256({
    aarch64: 'af6025427fb18b30b14ec3161e27ecf1d5042fbc9d37d767ede33d6a50fbc1c1',
     armv7l: 'af6025427fb18b30b14ec3161e27ecf1d5042fbc9d37d767ede33d6a50fbc1c1',
     x86_64: '6ec6e56cc039e43d03031de00c2dd0347826124407d60ed754ee3f82dcd9cae8'
  })

  depends_on 'cairo' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'libxml2' # R
  depends_on 'pango' # R

  meson_options '-Dgtk_doc=false'
end
