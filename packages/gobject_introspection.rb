require 'buildsystems/meson'

class Gobject_introspection < Meson
  description 'GObject introspection is a middleware layer between C libraries (using GObject) and language bindings.'
  homepage 'https://wiki.gnome.org/action/show/Projects/GObjectIntrospection'
  version '1.80.1-py3.12'
  license 'LGPL-2+ and GPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/gobject-introspection.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a747463eebb4e9fa8dc3911e048ab7ea76657bab5d435df31e2211f425d2525f',
     armv7l: 'a747463eebb4e9fa8dc3911e048ab7ea76657bab5d435df31e2211f425d2525f',
     x86_64: '00e09ff95436dfe99998c60d968b2364affca461f1034d8bf38e5f9d2790e616'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'libffi' # R
  depends_on 'python3' # R
  depends_on 'py3_setuptools' => :build

  gnome
end
