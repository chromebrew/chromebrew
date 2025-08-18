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
    aarch64: '35a9e95ee6a51d9558976463f93a6914ba41068ad6c9e1227d2f391ae9856039',
     armv7l: '35a9e95ee6a51d9558976463f93a6914ba41068ad6c9e1227d2f391ae9856039',
     x86_64: '5ae60181f7b6635d92cca1096faa9ac99b7c8ffd9aaacf56e05fe703366427ba'
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
