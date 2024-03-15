require 'buildsystems/meson'

class Folks < Meson
  description 'Library to aggregates people into metacontacts'
  homepage 'https://wiki.gnome.org/Projects/Folks'
  version '0.15.7'
  license 'LGPL-2.1'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/folks.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '04b037c6f131277cf5b006d6c5ced26d0f7b055831c1f7fc63b3ff2a65df0ea2'
  })

  depends_on 'evolution_data_server' => :build
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'libgee' # R
  depends_on 'libxml2' # R
  depends_on 'readline' # R
  depends_on 'vala' => :build

  gnome

  meson_options '-Dbluez_backend=false \
    -Ddocs=false \
    -Deds_backend=false \
    -Dinstalled_tests=false \
    -Dofono_backend=false \
    -Dtelepathy_backend=false \
    -Dtests=false'
end
