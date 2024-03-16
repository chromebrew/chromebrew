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
    aarch64: '52979c485f2f9a6dc783f9a335e19c664d0d18ea9bf0423c561697138840bb91',
     armv7l: '52979c485f2f9a6dc783f9a335e19c664d0d18ea9bf0423c561697138840bb91',
     x86_64: 'a855bb36d96c03536fabf1069acda9347df3c7aa83c34dcbe7baad74c2edfb81'
  })

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
