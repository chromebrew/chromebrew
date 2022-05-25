require 'buildsystems/meson'

class Appstream_glib < Meson
  description 'Objects and methods for reading and writing AppStream metadata'
  homepage 'https://people.freedesktop.org/~hughsient/appstream-glib/'
  version '0.8.2'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/hughsie/appstream-glib.git'
  git_hashtag 'appstream_glib_0_8_2'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/appstream_glib/0.8.2_armv7l/appstream_glib-0.8.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/appstream_glib/0.8.2_armv7l/appstream_glib-0.8.2-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/appstream_glib/0.8.2_x86_64/appstream_glib-0.8.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2a591cfad5df70455b2ff90f915ae057f8e5efc1e95e22c29bd5a78c9406e48e',
     armv7l: '2a591cfad5df70455b2ff90f915ae057f8e5efc1e95e22c29bd5a78c9406e48e',
     x86_64: '2a10e4da59cadb05dadd12364062fea9050883cb550bd8ca14c4b985fda87f3c'
  })

  depends_on 'cairo'
  depends_on 'docbook'
  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'gcab'
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'gobject_introspection' => :build
  depends_on 'gperf' => :build
  depends_on 'gtk3'
  depends_on 'gtk_doc' => :build
  depends_on 'json_glib'
  depends_on 'libarchive'
  depends_on 'libjpeg'
  depends_on 'libsoup'
  depends_on 'libsoup2'
  depends_on 'libstemmer'
  depends_on 'libuuid'
  depends_on 'libyaml'
  depends_on 'pango'
  depends_on 'util_linux'

  meson_options '-Dintrospection=true -Drpm=false'
end
