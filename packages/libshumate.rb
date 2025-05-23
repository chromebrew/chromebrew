# Adapted from Arch Linux libshumate PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=libshumate

require 'buildsystems/meson'

class Libshumate < Meson
  description 'GTK toolkit providing widgets for embedded maps'
  homepage 'https://wiki.gnome.org/Projects/libshumate'
  version '1.4.0'
  license 'LGPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/libshumate.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4a4577c39d8caa021ffadef5f3f0dee74e526e2405cada79350874b7fbc4f864',
     armv7l: '4a4577c39d8caa021ffadef5f3f0dee74e526e2405cada79350874b7fbc4f864',
     x86_64: '5de54c106089ab7dbf632167bc8a98cb1d421d9d27bb715f883780c78faca834'
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
