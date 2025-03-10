# Only a meson build creates the pkgconfig files needed for other builds.
require 'buildsystems/meson'

class Py3_pygobject < Meson
  description 'PyGObject is a Python package which provides bindings for GObject based libraries such as GTK+, GStreamer, WebKitGTK+, GLib, GIO and many more.'
  homepage 'https://pygobject.gnome.org/'
  version "3.52.1-#{CREW_PY_VER}"
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/pygobject.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3458a74bfde1ac8e51ee68c633eafe8253fb0e1dbe3320a69c4a8c2eaa70f3b6',
     armv7l: '3458a74bfde1ac8e51ee68c633eafe8253fb0e1dbe3320a69c4a8c2eaa70f3b6',
     x86_64: 'c9fab17d3ff1dd7e0cd463beabd5d9fc9d39e2c6ddaa762a9aa93739828cf40a'
  })

  depends_on 'cairo' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' # R
  depends_on 'harfbuzz' # R
  depends_on 'libffi' # R
  depends_on 'py3_meson_python' => :build
  depends_on 'py3_pycairo' => :build
  depends_on 'python3' # R
  depends_on 'wayland' => :build

  meson_options '-Dtests=false'
end
