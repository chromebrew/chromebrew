# Adapted from Arch Linux libgedit-gtksourceview PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=libgedit-gtksourceview

require 'buildsystems/meson'

class Libgedit_gtksourceview < Meson
  description 'A library that extends GtkTextView, the standard GTK '
  homepage 'https://gedit-technology.github.io'
  version '299.5.0'
  license 'LGPL2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/World/gedit/libgedit-gtksourceview.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4b6bbcebe2578342907bd5116110e4fccd46ff000b16d6883da636c75f7f2cc7',
     armv7l: '4b6bbcebe2578342907bd5116110e4fccd46ff000b16d6883da636c75f7f2cc7',
     x86_64: '1fd2f299c0a789895b5671daad278b76817a3b1672881d0bebd20fc581fa97c2'
  })

  depends_on 'cairo' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'libxml2' # R
  depends_on 'pango' # R

  meson_options '-Dgtk_doc=false'
end
