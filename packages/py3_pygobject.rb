# Only a meson build creates the pkgconfig files needed for other builds.
require 'buildsystems/meson'

class Py3_pygobject < Meson
  description 'PyGObject is a Python package which provides bindings for GObject based libraries such as GTK+, GStreamer, WebKitGTK+, GLib, GIO and many more.'
  homepage 'https://wiki.gnome.org/Projects/PyGObject'
  version "3.58.1-#{CREW_PY_VER}"
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/pygobject.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7d3161df3e31d386dccc1c4729f191240b875f14f6eb09711a26c7b111fd3cab',
     armv7l: '7d3161df3e31d386dccc1c4729f191240b875f14f6eb09711a26c7b111fd3cab',
     x86_64: 'e259086c31b7a20949050d650bdb50d651de5aaa683aa44d642638fc5b1735f6'
  })

  depends_on 'cairo' => :library
  depends_on 'gcc_lib' # R
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'harfbuzz' => :library
  depends_on 'libffi' => :library
  depends_on 'py3_meson_python' => :build
  depends_on 'py3_pycairo' => :build
  depends_on 'python3' # R
  depends_on 'wayland' => :build

  meson_options '-Dtests=false'
end
