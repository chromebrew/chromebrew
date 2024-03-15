require 'buildsystems/meson'

class Gobject_introspection < Meson
  description 'GObject introspection is a middleware layer between C libraries (using GObject) and language bindings.'
  homepage 'https://wiki.gnome.org/action/show/Projects/GObjectIntrospection'
  @_ver = '1.80.0'
  version "#{@_ver}-py3.12"
  license 'LGPL-2+ and GPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/gobject-introspection.git'
  git_hashtag @_ver
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0922ab24d17e086daf1078aba52e8437f192baeb203643912bb7832c67d6eb8d',
     armv7l: '0922ab24d17e086daf1078aba52e8437f192baeb203643912bb7832c67d6eb8d',
     x86_64: '8686243750b6c522da0a5540b81c1ccfb616118c4a141d25b58e79ecdf7cd03d'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'libffi' # R
  depends_on 'python3' # R
  depends_on 'py3_setuptools' => :build

  gnome
end
