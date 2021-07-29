require 'package'

class Pygobject < Package
  description 'PyGObject is a Python package which provides bindings for GObject based libraries such as GTK+, GStreamer, WebKitGTK+, GLib, GIO and many more.'
  homepage 'https://pygobject.readthedocs.io/'
  @_ver = '3.40.1'
  version @_ver
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/pygobject.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pygobject/3.40.1_armv7l/pygobject-3.40.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pygobject/3.40.1_armv7l/pygobject-3.40.1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pygobject/3.40.1_i686/pygobject-3.40.1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pygobject/3.40.1_x86_64/pygobject-3.40.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '1500e6bc54033b30b095bee58fed4690d614c765671bd3722688e76b78fe454e',
     armv7l: '1500e6bc54033b30b095bee58fed4690d614c765671bd3722688e76b78fe454e',
       i686: 'ebe701b39d9ca9fb0b394333c92eab82ff76d3126566bcefc140b800a0356f48',
     x86_64: '25669c04d58e2f76ea77ef6d7f9235feb608291dbdf8632bb8dd5c1e4cd44fe9'
  })

  depends_on 'glib'
  depends_on 'gobject_introspection'
  depends_on 'py3_pycairo'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
