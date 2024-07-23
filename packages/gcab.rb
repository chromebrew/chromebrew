require 'buildsystems/meson'

class Gcab < Meson
  description 'A GObject library to create cabinet files'
  homepage 'https://gitlab.gnome.org/GNOME/gcab'
  version '1.6'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/gcab.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f9ba7c254adce2f4c3b622bce9272867efc38257b3ca6f062ca28fe41a8d0cbf',
     armv7l: 'f9ba7c254adce2f4c3b622bce9272867efc38257b3ca6f062ca28fe41a8d0cbf',
       i686: '83da57fe5363d0b06c110da0546c37c8e4d5ee1146a97f2b59681a889c29157f',
     x86_64: '4915b0c6903d89b7b759e0efd8ee04691b63e594490025d472f5c7a29ea27acc'
  })

  depends_on 'gobject_introspection' => :build
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'zlibpkg' # R

  gnome

  meson_options '-Ddocs=false \
      -Dtests=false \
      -Dvapi=false'
end
