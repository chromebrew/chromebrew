require 'buildsystems/meson'

class Gobject_introspection < Meson
  description 'GObject introspection is a middleware layer between C libraries (using GObject) and language bindings.'
  homepage 'https://wiki.gnome.org/action/show/Projects/GObjectIntrospection'
  version "1.81.4-#{CREW_PY_VER}"
  license 'LGPL-2+ and GPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/gobject-introspection.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '160e81f4e83e853bfcd5a16394eaa2b458c6cf1cca65d958f7eea4c8c95a806d',
     armv7l: '160e81f4e83e853bfcd5a16394eaa2b458c6cf1cca65d958f7eea4c8c95a806d',
     x86_64: '8529db83792eb3dd859fd3a20fe2a700d628e34d3954db629d7dc9ce508df85b'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'libffi' # R
  depends_on 'python3' # R
  depends_on 'py3_setuptools' => :build

  gnome
end
