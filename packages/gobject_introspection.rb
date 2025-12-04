require 'buildsystems/meson'

class Gobject_introspection < Meson
  description 'GObject introspection is a middleware layer between C libraries (using GObject) and language bindings.'
  homepage 'https://wiki.gnome.org/Projects/GObjectIntrospection'
  version "1.86.0-#{CREW_PY_VER}"
  license 'LGPL-2+ and GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gobject-introspection.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e74ffa6c249c58aafe0088f280eac429ed2453ca5de082892415af246606539d',
     armv7l: 'e74ffa6c249c58aafe0088f280eac429ed2453ca5de082892415af246606539d',
     x86_64: '1bad47ed12d541243679a21183f5ed73db23cda81ed762e68a3d792cd88a3e7b'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'libffi' # R
  depends_on 'py3_setuptools' => :build
  depends_on 'python3' # R

  gnome
end
