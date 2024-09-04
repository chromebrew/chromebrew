require 'buildsystems/pip'

class Py3_pygobject < Pip
  description 'PyGObject is a Python package which provides bindings for GObject based libraries such as GTK+, GStreamer, WebKitGTK+, GLib, GIO and many more.'
  homepage 'https://pygobject.gnome.org/'
  version '3.48.2-py3.12'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/pygobject.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9c20d1c394f4c35bf3fad8cd0e015734dd48b227762f23fd53b059d5acf5e060',
     armv7l: '9c20d1c394f4c35bf3fad8cd0e015734dd48b227762f23fd53b059d5acf5e060',
     x86_64: '052613b256000800d203abcc5dfa1704fbfa85755acc7a3f818b7e625d51bf10'
  })

  depends_on 'cairo' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' # R
  depends_on 'harfbuzz' # R
  depends_on 'libffi' # R
  depends_on 'py3_pycairo' => :build
  depends_on 'python3' # R
  depends_on 'wayland' => :build
end
