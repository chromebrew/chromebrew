require 'buildsystems/meson'

class Gobject_introspection < Meson
  description 'GObject introspection is a middleware layer between C libraries (using GObject) and language bindings.'
  homepage 'https://wiki.gnome.org/Projects/GObjectIntrospection'
  version "1.86.0-1-#{CREW_PY_VER}"
  license 'LGPL-2+ and GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gobject-introspection.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '460ffea87296475698c8772a3e4504cea6c2c04a0be0a6432ff4b81878174580',
     armv7l: '460ffea87296475698c8772a3e4504cea6c2c04a0be0a6432ff4b81878174580',
     x86_64: 'fbbc3be5f8c6917d4673bd7c75697efaa45ee146ef97d271d133748f94f97e13'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'libffi' # R
  depends_on 'py3_setuptools' => :build
  depends_on 'python3' # R

  gnome
end
