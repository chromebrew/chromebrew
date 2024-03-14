require 'buildsystems/meson'

class Json_glib < Meson
  description 'JSON-GLib implements a full suite of JSON-related tools using GLib and GObject.'
  homepage 'https://wiki.gnome.org/Projects/JsonGlib'
  version '1.6.6'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/json-glib.git'
  git_hashtag version
  binary_compression 'tpxz'

  binary_sha256({
    aarch64: '37724d89adff90c65166c4f9f908bd1f4184ed5422caea9ec31fab941abbc947',
     armv7l: '37724d89adff90c65166c4f9f908bd1f4184ed5422caea9ec31fab941abbc947',
       i686: '08a05f309d75ee639cc009973f03de5018d6306080d6feac96a3792597eb348c',
     x86_64: '40a0670356d43d4154b89ea2d0543b9db01b5920bc04b8d144d56a1de78d418c'
  })

  depends_on 'gtk_doc'
  depends_on 'glib'
  depends_on 'gobject_introspection'

  gnome
end
