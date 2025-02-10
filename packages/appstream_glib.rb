require 'buildsystems/meson'

class Appstream_glib < Meson
  description 'Objects and methods for reading and writing AppStream metadata'
  homepage 'https://people.freedesktop.org/~hughsient/appstream-glib/'
  version '0.8.3'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/hughsie/appstream-glib.git'
  git_hashtag "appstream_glib_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ef6e1cb2540ec553015b679cc0784e598bd55f462ed4a984eba94b43fe9cd24a',
     armv7l: 'ef6e1cb2540ec553015b679cc0784e598bd55f462ed4a984eba94b43fe9cd24a',
     x86_64: 'cc23b59bb3432eb68886c03f9109967d8975dc71a3170734032d846ea332341c'
  })

  depends_on 'cairo' # R
  depends_on 'curl' # R
  depends_on 'docbook' => :build
  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'gcab' => :build
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gperf' => :build
  depends_on 'gtk3' # R
  depends_on 'gtk_doc' => :build
  depends_on 'harfbuzz' # R
  depends_on 'json_glib' # R
  depends_on 'libarchive' # R
  depends_on 'libjpeg_turbo' => :build
  depends_on 'libsoup2' => :build
  depends_on 'libsoup' => :build
  depends_on 'libstemmer' => :build
  depends_on 'libyaml' # R
  depends_on 'pango' # R
  depends_on 'util_linux' # R

  meson_options '-Dintrospection=true -Dman=false -Drpm=false'
end
