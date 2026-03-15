# Adapted from Arch Linux libshumate PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=libshumate

require 'buildsystems/meson'

class Libshumate < Meson
  description 'GTK toolkit providing widgets for embedded maps'
  homepage 'https://wiki.gnome.org/Projects/libshumate'
  version '1.6.0'
  license 'LGPL2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/libshumate.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6f31865bc039ad05a37650429b3acd104cb84d0d2383f52bda27e7c18671c086',
     armv7l: '6f31865bc039ad05a37650429b3acd104cb84d0d2383f52bda27e7c18671c086',
     x86_64: '9d4f3c6988e1c371269b7ce94ba2e4b7112a7f9139fbcfeb841f94ace90f3eb6'
  })

  depends_on 'cairo' # R
  depends_on 'gcc_lib' => :build
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gperf' => :build
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
