# Adapted from Arch Linux libshumate PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=libshumate

require 'buildsystems/meson'

class Libshumate < Meson
  description 'GTK toolkit providing widgets for embedded maps'
  homepage 'https://wiki.gnome.org/Projects/libshumate'
  version '1.6.1'
  license 'LGPL2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/libshumate.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '04ff1b6125f8b4893c9f1d2b524001d881721999244ee16b25c5ec8d05afff6f',
     armv7l: '04ff1b6125f8b4893c9f1d2b524001d881721999244ee16b25c5ec8d05afff6f',
     x86_64: '032addf69f0a2904243afaf52df1d124c50a74c858156a1e3e07c1c99a801ed3'
  })

  depends_on 'cairo' => :library
  depends_on 'gcc_lib' => :build
  depends_on 'gdk_pixbuf' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'gobject_introspection' => :build
  depends_on 'gperf' => :build
  depends_on 'graphene' => :library
  depends_on 'gtk4' => :library
  depends_on 'harfbuzz' # R
  depends_on 'json_glib' => :library
  depends_on 'libsoup' => :library
  depends_on 'pango' => :library
  depends_on 'protobuf_c' => :library
  depends_on 'sqlite' # R
  depends_on 'vala' => :build

  gnome

  meson_options '-Dsysprof=disabled -Dgtk_doc=false'
end
