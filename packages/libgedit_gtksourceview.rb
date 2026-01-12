# Adapted from Arch Linux libgedit-gtksourceview PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=libgedit-gtksourceview

require 'buildsystems/meson'

class Libgedit_gtksourceview < Meson
  description 'A library that extends GtkTextView, the standard GTK '
  homepage 'https://gedit-technology.github.io'
  version '299.6.0'
  license 'LGPL2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/World/gedit/libgedit-gtksourceview.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bf33b299ce17545a74dac05054979e2fece05c13cb9cf0a1bac83bc728ab3124',
     armv7l: 'bf33b299ce17545a74dac05054979e2fece05c13cb9cf0a1bac83bc728ab3124',
     x86_64: 'c61d8bb63dc8ced4d3b10b863c750bc5c1f411b36ee858d5eabfa1b1a7cfe47a'
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
