require 'buildsystems/meson'

class Libchamplain < Meson
  description 'A map widget'
  homepage 'https://wiki.gnome.org/Projects/libchamplain'
  version '0.12.21'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/libchamplain.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9c602330fb220edd4fed88b2334085681e122dc6b6ca446bcfdd28cc3f6f32b6',
     armv7l: '9c602330fb220edd4fed88b2334085681e122dc6b6ca446bcfdd28cc3f6f32b6',
     x86_64: 'bf46b5fa85e83d1222d9008006b4da6f03280099560b47864acea66b8745829a'
  })

  depends_on 'cairo' # R
  depends_on 'clutter_gtk' # R
  depends_on 'clutter' # R
  depends_on 'cogl' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk3' # R
  depends_on 'gtk_doc' => :build
  depends_on 'harfbuzz' # R
  depends_on 'libsoup' # R
  depends_on 'pango' # R
  depends_on 'sqlite' # R
  depends_on 'vala' => :build

  gnome
end
