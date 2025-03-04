require 'buildsystems/meson'

class Clutter_gtk < Meson
  description 'The Clutter Gtk package is a library providing facilities to integrate Clutter into GTK+ applications.'
  homepage 'https://wiki.gnome.org/Attic/Clutter'
  version '1.8.4'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/Archive/clutter-gtk.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5de438b722b6d124a47372f1055cb68b39afc349af9942aba985ee873b03901d',
     armv7l: '5de438b722b6d124a47372f1055cb68b39afc349af9942aba985ee873b03901d',
     x86_64: '41491cec67a670ba413b95d0867e72049cc099a436d40c81f40734d87445c740'
  })

  depends_on 'clutter'
  depends_on 'gobject_introspection'
  depends_on 'gtk3'
  depends_on 'cairo' # R
  depends_on 'harfbuzz' # R
  depends_on 'cogl' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'wayland' # R
end
