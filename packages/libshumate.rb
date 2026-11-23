# Adapted from Arch Linux libshumate PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=libshumate

require 'buildsystems/meson'

class Libshumate < Meson
  description 'GTK toolkit providing widgets for embedded maps'
  homepage 'https://wiki.gnome.org/Projects/libshumate'
  version '1.7.1'
  license 'LGPL2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/libshumate.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fe14d949b16c56ba1e8f08bf61a92752cc4d44b6bc4dab91e00c47fba9d6ad75',
     armv7l: 'fe14d949b16c56ba1e8f08bf61a92752cc4d44b6bc4dab91e00c47fba9d6ad75',
     x86_64: 'ca3b63917675acb7e41deeedb2603f9c96852daf5d6543710e2ece603f5bc826'
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
