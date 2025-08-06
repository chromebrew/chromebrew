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
    aarch64: '331b56aa0087d0387c1ef6c709a26441b8f560b404641c6e7b2e84895d0bfd62',
     armv7l: '331b56aa0087d0387c1ef6c709a26441b8f560b404641c6e7b2e84895d0bfd62',
     x86_64: 'd25eebee63ccd2922b04b113db5b84b340d5b8ec5684020505600e78c7e2462a'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gobject_introspection' => :build

  # https://gitlab.gnome.org/GNOME/json-glib/-/issues/72
  meson_options '-Ddocumentation=disabled -Dtests=false'
  # run_tests
end
