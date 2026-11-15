# Adapted from Arch Linux libshumate PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=libshumate

require 'buildsystems/meson'

class Libshumate < Meson
  description 'GTK toolkit providing widgets for embedded maps'
  homepage 'https://wiki.gnome.org/Projects/libshumate'
  version '1.7.0'
  license 'LGPL2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/libshumate.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a5384a1bc629457cab7abdfc4dc4ca50faf2786297a83e81bb423f070426f58c',
     armv7l: 'a5384a1bc629457cab7abdfc4dc4ca50faf2786297a83e81bb423f070426f58c',
     x86_64: '43333fd07982153b29176d6679f9ad3578083e04bea08bdf4c2cee93ea3766ed'
  })

  depends_on 'cairo' => :library
  depends_on 'gcc_lib' => :build
  depends_on 'gdk_pixbuf' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
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
