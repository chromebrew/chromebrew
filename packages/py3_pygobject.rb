# Only a meson build creates the pkgconfig files needed for other builds.
require 'buildsystems/meson'

class Py3_pygobject < Meson
  description 'PyGObject is a Python package which provides bindings for GObject based libraries such as GTK+, GStreamer, WebKitGTK+, GLib, GIO and many more.'
  homepage 'https://wiki.gnome.org/Projects/PyGObject'
  version "3.56.3-#{CREW_PY_VER}"
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/pygobject.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '404e13b79c708609d8488689f7abe4784d9aed28778b368b5e0aed8fcf671bdd',
     armv7l: '404e13b79c708609d8488689f7abe4784d9aed28778b368b5e0aed8fcf671bdd',
     x86_64: 'f7c7ffd85bb808fa3e4ad76049239a94261c513d8425acde9728598c67d7492d'
  })

  depends_on 'cairo' => :library
  depends_on 'gcc_lib' # R
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'harfbuzz' => :library
  depends_on 'libffi' => :library
  depends_on 'py3_meson_python' => :build
  depends_on 'py3_pycairo' => :build
  depends_on 'python3' # R
  depends_on 'wayland' => :build

  meson_options '-Dtests=false'
end
