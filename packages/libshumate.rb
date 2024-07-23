# Adapted from Arch Linux libshumate PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=libshumate

require 'buildsystems/meson'

class Libshumate < Meson
  description 'GTK toolkit providing widgets for embedded maps'
  homepage 'https://wiki.gnome.org/Projects/libshumate'
  version '1.2.rc2'
  license 'LGPL'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/libshumate.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '370044f75080c1149725e608c1a455f6918f76a26e2402008f68bd8f65c140e2',
     armv7l: '370044f75080c1149725e608c1a455f6918f76a26e2402008f68bd8f65c140e2',
     x86_64: '8f79c0bc9c97cf72c48cc64b88064b74ee95196f4be9be664002670be8c29175'
  })

  depends_on 'cairo' # R
  depends_on 'gcc_lib' => :build
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'graphene' # R
  depends_on 'gtk4' # R
  depends_on 'harfbuzz' # R
  depends_on 'json_glib' # R
  depends_on 'libsoup' # R
  depends_on 'pango' # R
  depends_on 'protobuf_c' # R
  depends_on 'sqlite' # R
  depends_on 'vala' => :build

  gnome

  meson_options '-Dsysprof=disabled -Dgtk_doc=false'
end
