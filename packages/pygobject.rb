require 'package'

class Pygobject < Package
  description 'PyGObject is a Python package which provides bindings for GObject based libraries such as GTK+, GStreamer, WebKitGTK+, GLib, GIO and many more.'
  homepage 'https://pygobject.readthedocs.io/'
  @_ver = '3.42.0'
  version "#{@_ver}-1"
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/pygobject.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pygobject/3.42.0-1_armv7l/pygobject-3.42.0-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pygobject/3.42.0-1_armv7l/pygobject-3.42.0-1-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pygobject/3.42.0-1_x86_64/pygobject-3.42.0-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '8d3c72f92d272438ada7781dc3c7e2830e92c5567b37000770a6a567398e4aee',
     armv7l: '8d3c72f92d272438ada7781dc3c7e2830e92c5567b37000770a6a567398e4aee',
     x86_64: '301494929ef6856b8278cbedaf77a2d6b73746826576671708dfbb4c866e84fd'
  })

  depends_on 'glib'
  depends_on 'wayland'
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
