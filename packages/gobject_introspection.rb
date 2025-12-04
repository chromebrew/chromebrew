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
    aarch64: 'a5cba3d959a91159377d03ae4e7d4c60d9751b2999fc9b2be7490f4d32249658',
     armv7l: 'a5cba3d959a91159377d03ae4e7d4c60d9751b2999fc9b2be7490f4d32249658',
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
