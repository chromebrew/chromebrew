# Only a meson build creates the pkgconfig files needed for other builds.
require 'buildsystems/meson'

class Py3_pygobject < Meson
  description 'PyGObject is a Python package which provides bindings for GObject based libraries such as GTK+, GStreamer, WebKitGTK+, GLib, GIO and many more.'
  homepage 'https://wiki.gnome.org/Projects/PyGObject'
  version "3.58.0-#{CREW_PY_VER}"
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/pygobject.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0f023487db4c6ba38bda1d1dd3179d4c7af19b738e67b8723a91208fde239031',
     armv7l: '0f023487db4c6ba38bda1d1dd3179d4c7af19b738e67b8723a91208fde239031',
     x86_64: 'd492c8dc166fe759ee7cab53bcf321a3adfd51d6f931d11fc6e4ac049ff183fc'
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
