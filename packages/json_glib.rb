require 'buildsystems/meson'

class Json_glib < Meson
  description 'JSON-GLib implements a full suite of JSON-related tools using GLib and GObject.'
  homepage 'https://gitlab.gnome.org/GNOME/json-glib'
  version '1.10.8'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/json-glib.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6b8f27aa0b2820fd24d28eb955a955d7a24140d649134b9a1783e6f9555c00ba',
     armv7l: '6b8f27aa0b2820fd24d28eb955a955d7a24140d649134b9a1783e6f9555c00ba',
     x86_64: 'b8e98d728181ba2bf67eab02805d600a5f2812d119ebe6faf2f264961963ff6c'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gobject_introspection' => :build

  # https://gitlab.gnome.org/GNOME/json-glib/-/issues/72
  meson_options '-Ddocumentation=disabled -Dtests=false'
  # run_tests
end
