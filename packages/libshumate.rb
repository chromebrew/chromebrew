# Adapted from Arch Linux libshumate PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=libshumate

require 'buildsystems/meson'

class Libshumate < Meson
  description 'GTK toolkit providing widgets for embedded maps'
  homepage 'https://wiki.gnome.org/Projects/libshumate'
  version '1.6.3'
  license 'LGPL2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/libshumate.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '808aa6894529e5d99ab64cf9e212221d9fceddc6b9c664581e6665bb2827ccb1',
     armv7l: '808aa6894529e5d99ab64cf9e212221d9fceddc6b9c664581e6665bb2827ccb1',
     x86_64: 'a77b8175badefd08a564ee54354a341f662be31d845a9295d55cd45d044b6069'
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
