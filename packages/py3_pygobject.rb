# Only a meson build creates the pkgconfig files needed for other builds.
require 'buildsystems/meson'

class Py3_pygobject < Meson
  description 'PyGObject is a Python package which provides bindings for GObject based libraries such as GTK+, GStreamer, WebKitGTK+, GLib, GIO and many more.'
  homepage 'https://wiki.gnome.org/Projects/PyGObject'
  version "3.56.2-#{CREW_PY_VER}"
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/pygobject.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '54b3776f52a1729d3f875cf20343951a89fa7a728a4eed45e9948665381d8d8a',
     armv7l: '54b3776f52a1729d3f875cf20343951a89fa7a728a4eed45e9948665381d8d8a',
     x86_64: 'd626b727d8210fd48dc83368bfc8b09362f323613d75abb8c078340fdf82399f'
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
