require 'buildsystems/meson'

class Gobject_introspection < Meson
  description 'GObject introspection is a middleware layer between C libraries (using GObject) and language bindings.'
  homepage 'https://wiki.gnome.org/action/show/Projects/GObjectIntrospection'
  version "1.84.0-#{CREW_PY_VER}-1"
  license 'LGPL-2+ and GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gobject-introspection.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b328f3748aa5a2aa976436312b5e5959d1ea6c35d11e48d1f4040b345007928a',
     armv7l: 'b328f3748aa5a2aa976436312b5e5959d1ea6c35d11e48d1f4040b345007928a',
     x86_64: 'cc92e25026d88db508795b6aa880a48496a508df00dea842f57d366cf19cfa48'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'libffi' # R
  depends_on 'python3' # R
  depends_on 'py3_setuptools' => :build

  gnome
end
