# Adapted from Arch Linux libshumate PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=libshumate

require 'buildsystems/meson'

class Libshumate < Meson
  description 'GTK toolkit providing widgets for embedded maps'
  homepage 'https://wiki.gnome.org/Projects/libshumate'
  version '1.6.2'
  license 'LGPL2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/libshumate.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '296b0882693dc756f4aa5882f43a6a7c3c2f1dfd7cbacfa92de2819fe99a1e54',
     armv7l: '296b0882693dc756f4aa5882f43a6a7c3c2f1dfd7cbacfa92de2819fe99a1e54',
     x86_64: '74de189043f646facfc058cb07013222adc497a26fdfbdebf46aa228c4b07f55'
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
