require 'buildsystems/meson'

class Folks < Meson
  description 'Library to aggregates people into metacontacts'
  homepage 'https://wiki.gnome.org/Projects/Folks'
  version '0.15.9'
  license 'LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/folks.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '491428b6cb2de8c119ab455aded923b3edc697ec7f894be547eba5d9e7101384',
     armv7l: '491428b6cb2de8c119ab455aded923b3edc697ec7f894be547eba5d9e7101384',
     x86_64: '5acbdbbf7fe754124a526bcb1ae856af49b7ba907346e7fcc2cbec06c85e6464'
  })

  depends_on 'glibc' # R
  depends_on 'glib' # R
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
