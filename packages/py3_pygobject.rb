# Only a meson build creates the pkgconfig files needed for other builds.
require 'buildsystems/meson'

class Py3_pygobject < Meson
  description 'PyGObject is a Python package which provides bindings for GObject based libraries such as GTK+, GStreamer, WebKitGTK+, GLib, GIO and many more.'
  homepage 'https://pygobject.gnome.org/'
  version "3.54.5-#{CREW_PY_VER}"
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/pygobject.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '377784280ae1cd9c73d5a586bb59a58e2ffc77f05e53a46e048b8d7a1ed2e783',
     armv7l: '377784280ae1cd9c73d5a586bb59a58e2ffc77f05e53a46e048b8d7a1ed2e783',
     x86_64: 'd767aba17036cfcb2d9ae413085da84779313807128d046c5143433926716b35'
  })

  depends_on 'cairo' # R
  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R
  depends_on 'libffi' # R
  depends_on 'py3_meson_python' => :build
  depends_on 'py3_pycairo' => :build
  depends_on 'python3' # R
  depends_on 'wayland' => :build

  meson_options '-Dtests=false'
end
