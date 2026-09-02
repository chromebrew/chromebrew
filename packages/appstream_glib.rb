require 'buildsystems/meson'

class Appstream_glib < Meson
  description 'Objects and methods for reading and writing AppStream metadata'
  homepage 'https://people.freedesktop.org/~hughsient/appstream-glib/'
  version '0.8.4'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/hughsie/appstream-glib.git'
  git_hashtag "appstream_glib_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7347e65dcaff9ebc286c9803329659f72b3989a034ee66f1ddebbdd788fa1a15',
     armv7l: '7347e65dcaff9ebc286c9803329659f72b3989a034ee66f1ddebbdd788fa1a15',
     x86_64: 'be19d39cde627ae56f7bcffdfe037bbf3d54e0440289774786f986d3c05033ec'
  })

  depends_on 'cairo' => :library
  depends_on 'curl' => :library
  depends_on 'docbook' => :build
  depends_on 'fontconfig' => :library
  depends_on 'freetype' => :library
  depends_on 'gcab' => :build
  depends_on 'gdk_pixbuf' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gobject_introspection' => :build
  depends_on 'gperf' => :build
  depends_on 'gtk3' => :library
  depends_on 'gtk_doc' => :build
  depends_on 'harfbuzz' => :library
  depends_on 'json_glib' => :library
  depends_on 'libarchive' => :library
  depends_on 'libjpeg_turbo' => :build
  depends_on 'libsoup' => :build
  depends_on 'libsoup2' => :build
  depends_on 'libstemmer' => :build
  depends_on 'libyaml' => :library
  depends_on 'pango' => :library
  depends_on 'util_linux' => :library

  meson_options '-Dintrospection=true -Dman=false -Drpm=false'
end
