require 'package'

class Pygobject < Package
  description 'PyGObject is a Python package which provides bindings for GObject based libraries such as GTK+, GStreamer, WebKitGTK+, GLib, GIO and many more.'
  homepage 'https://pygobject.readthedocs.io/'
  @_ver = '3.42.2'
  version "#{@_ver}-py3.11"
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/pygobject.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pygobject/3.42.2-py3.11_armv7l/pygobject-3.42.2-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pygobject/3.42.2-py3.11_armv7l/pygobject-3.42.2-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pygobject/3.42.2-py3.11_i686/pygobject-3.42.2-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pygobject/3.42.2-py3.11_x86_64/pygobject-3.42.2-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'bf7cc57f4234312fc1f70020191c9b379fb7e0eb0bfee62d1e80a0cd0bef54bb',
     armv7l: 'bf7cc57f4234312fc1f70020191c9b379fb7e0eb0bfee62d1e80a0cd0bef54bb',
       i686: 'b7ad228d54a7d9ba404b91f53719b4ed46b98ed799e6973b70af780fe75e0469',
     x86_64: '21d0f6be5f2fbffbaeeefa8b0420650e1377f21cc99b0646b3ab4c2a0fd3f1af'
  })

  depends_on 'glib'
  depends_on 'wayland'
  depends_on 'gobject_introspection'
  depends_on 'py3_pycairo'
  depends_on 'py3_setuptools' => :build
  depends_on 'python3'
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R
  depends_on 'libffi' # R

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
