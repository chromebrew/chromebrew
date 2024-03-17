require 'buildsystems/meson'

class Json_glib < Meson
  description 'JSON-GLib implements a full suite of JSON-related tools using GLib and GObject.'
  homepage 'https://wiki.gnome.org/Projects/JsonGlib'
  version '1.8.1-b3774f5'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/json-glib.git'
  git_hashtag 'b3774f57ad9df8f102f26a4779ef10621d7b209f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4991c79fa0d864832c0a95b1ddae94e3c454d13d2655d54492cca3592359c014',
     armv7l: '4991c79fa0d864832c0a95b1ddae94e3c454d13d2655d54492cca3592359c014',
     x86_64: '8ac5ade1321731697e30340321ff4607fea27f782f115a96fb02b06d29aa2a40'
  })

  depends_on 'gtk_doc' => :build
  depends_on 'glib' => :build
  depends_on 'gobject_introspection' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'llvm18_dev' => :build

  gnome
  # This needs to be built with 'CREW_LINKER=lld' set.
  meson_options '-Dgtk_doc=disabled -Dtests=false'
end
