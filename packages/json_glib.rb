require 'buildsystems/meson'

class Json_glib < Meson
  description 'JSON-GLib implements a full suite of JSON-related tools using GLib and GObject.'
  homepage 'https://gitlab.gnome.org/GNOME/json-glib'
  version '1.10.6'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/json-glib.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a907845c293113e9cb096924451e00db90ab02460fbb9be3aeb846db78f4be5f',
     armv7l: 'a907845c293113e9cb096924451e00db90ab02460fbb9be3aeb846db78f4be5f',
     x86_64: '212a85d881638611b9585bd77ae1d1605301e860da9e84bee32c0099816b2089'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gobject_introspection' => :build

  # https://gitlab.gnome.org/GNOME/json-glib/-/issues/72
  meson_options '-Ddocumentation=disabled -Dtests=false'
  # run_tests
end
