# Adapted from Arch Linux libgedit-gtksourceview PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=libgedit-gtksourceview

require 'buildsystems/meson'

class Libgedit_gtksourceview < Meson
  description 'A library that extends GtkTextView, the standard GTK '
  homepage 'https://gedit-technology.github.io'
  version '299.2.1'
  license 'LGPL2.1'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/gedit-technology/libgedit-gtksourceview.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6379ba00383a5eb73734d4ccf690fd92c9a638a5905746ab117dd2ddfc3c8da9',
     armv7l: '6379ba00383a5eb73734d4ccf690fd92c9a638a5905746ab117dd2ddfc3c8da9',
     x86_64: '155feea345e7a6a0451fb5eb7345a61f6e6e076befcb8d30f3814a094c3483a0'
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
