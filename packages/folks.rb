require 'buildsystems/meson'

class Folks < Meson
  description 'Library to aggregates people into metacontacts'
  homepage 'https://wiki.gnome.org/Projects/Folks'
  version '0.15.5'
  license 'LGPL-2.1'
  compatibility 'x86_64'
  source_url "https://gitlab.gnome.org/GNOME/folks/-/archive/#{version}/folks-#{version}.tar.bz2"
  source_sha256 'f79952f6b0c8f6c0fa2efefbcfc4d4875a2ee5e4518f7d4bf520b62b5c89568c'
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '8d5447fdd889e1f45f4f7178db791b0ff5fd7c5d7eac854872b43de36e44df4f'
  })

  depends_on 'libgee'
  depends_on 'evolution_data_server'
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'vala' => :build
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'libxml2' # R
  depends_on 'readline' # R

  gnome

  meson_options '-Dbluez_backend=false \
    -Ddocs=false \
    -Deds_backend=false \
    -Dinstalled_tests=false \
    -Dofono_backend=false \
    -Dtelepathy_backend=false \
    -Dtests=false'
end
