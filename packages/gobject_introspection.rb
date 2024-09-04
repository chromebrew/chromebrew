require 'buildsystems/meson'

class Gobject_introspection < Meson
  description 'GObject introspection is a middleware layer between C libraries (using GObject) and language bindings.'
  homepage 'https://wiki.gnome.org/action/show/Projects/GObjectIntrospection'
  version '1.81.4-py3.12'
  license 'LGPL-2+ and GPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/gobject-introspection.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '51823fe8ab79c344bac510ae6378ae9e44e6e4baf6de1507e34b613f4eb66814',
     armv7l: '51823fe8ab79c344bac510ae6378ae9e44e6e4baf6de1507e34b613f4eb66814',
     x86_64: '74fb47a741e23db93ddd75bd6feae51dc89c852f4fc039fb7481bb41dd0ccd03'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'libffi' # R
  depends_on 'python3' # R
  depends_on 'py3_setuptools' => :build

  gnome
end
