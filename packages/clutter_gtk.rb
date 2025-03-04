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
    aarch64: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     armv7l: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     x86_64: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
  })

  depends_on 'clutter'
  depends_on 'gobject_introspection'
  depends_on 'gtk3'
end
