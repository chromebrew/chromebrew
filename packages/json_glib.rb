require 'buildsystems/meson'

class Json_glib < Meson
  description 'JSON-GLib implements a full suite of JSON-related tools using GLib and GObject.'
  homepage 'https://gitlab.gnome.org/GNOME/json-glib'
  version '1.9.2'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/json-glib.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '128d527c17c8bdbdc73c1087a3fc217c655e9ccf9b4d1fd8ca8d2f182112e303',
     armv7l: '128d527c17c8bdbdc73c1087a3fc217c655e9ccf9b4d1fd8ca8d2f182112e303',
     x86_64: 'dcf895969512d01c7630c853772775e78e8ed1da6a18c43b9bfce49a2d784043'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gobject_introspection' => :build

  # https://gitlab.gnome.org/GNOME/json-glib/-/issues/72
  meson_options '-Dgtk_doc=disabled -Dtests=false'
  # run_tests
end
