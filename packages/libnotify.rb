require 'buildsystems/meson'

class Libnotify < Meson
  description 'A library for sending desktop notifications.'
  homepage 'https://gitlab.gnome.org/GNOME/libnotify'
  version '0.8.6'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/GNOME/libnotify.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9a7691fa8514a880032b36718ba86fd79ce44aafd47ad16fa478e6ca9dfff798',
     armv7l: '9a7691fa8514a880032b36718ba86fd79ce44aafd47ad16fa478e6ca9dfff798',
     x86_64: '9267537dec8630340c542e485b18dbdb1e03333d2d26b61bc174f1a78d89a37a'
  })

  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gobject_introspection' => :build

  gnome

  meson_options '-Dman=false \
    -Ddocbook_docs=disabled \
    -Dtests=false \
    -Dgtk_doc=false'
end
