require 'buildsystems/python'

class Pygobject < Python
  description 'PyGObject is a Python package which provides bindings for GObject based libraries such as GTK+, GStreamer, WebKitGTK+, GLib, GIO and many more.'
  homepage 'https://pygobject.readthedocs.io/'
  @_ver = '3.44.2'
  version "#{@_ver}-py3.12"
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/pygobject.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pygobject/3.44.2-py3.12_armv7l/pygobject-3.44.2-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pygobject/3.44.2-py3.12_armv7l/pygobject-3.44.2-py3.12-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pygobject/3.44.2-py3.12_x86_64/pygobject-3.44.2-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4151689b78c1ed1417be8750710016a6380cbaba071e7f654a52196bd3c0366f',
     armv7l: '4151689b78c1ed1417be8750710016a6380cbaba071e7f654a52196bd3c0366f',
     x86_64: '6f9d0d03cf9e4ee58d255a9ade73023c2ec1dc1b4a10a26dbe6210c2af5decd4'
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
