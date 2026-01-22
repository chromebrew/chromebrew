require 'buildsystems/meson'

class Folks < Meson
  description 'Library to aggregates people into metacontacts'
  homepage 'https://wiki.gnome.org/Projects/Folks'
  version '0.15.12'
  license 'LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/folks.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b31d41f4b77abafa041aae54486f730c3ab25e104c5982c480bf024926d3831a',
     armv7l: 'b31d41f4b77abafa041aae54486f730c3ab25e104c5982c480bf024926d3831a',
     x86_64: 'f4bf40195fafb9f12bde0ace0d04f4abdda18798319872b078f1c1745777fef9'
  })

  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'libgee' # R
  depends_on 'libxml2' # R
  depends_on 'readline' # R
  depends_on 'vala' => :build

  # https://gitlab.gnome.org/GNOME/folks/-/issues/120
  no_lto
  gnome

  meson_options '-Dbluez_backend=false -Deds_backend=false -Dofono_backend=false -Dtelepathy_backend=false'
  # https://gitlab.gnome.org/GNOME/folks/-/issues/143
  # run_tests
end
