require 'package'

class Pygobject < Package
  description 'PyGObject is a Python package which provides bindings for GObject based libraries such as GTK+, GStreamer, WebKitGTK+, GLib, GIO and many more.'
  homepage 'https://pygobject.readthedocs.io/'
  @_ver = '3.42.0'
  version @_ver
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/pygobject.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pygobject/3.42.0_armv7l/pygobject-3.42.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pygobject/3.42.0_armv7l/pygobject-3.42.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pygobject/3.42.0_i686/pygobject-3.42.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pygobject/3.42.0_x86_64/pygobject-3.42.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '3078465f299ca21b754eddacf8f3d10e5674cb93773288539010803a7024c339',
     armv7l: '3078465f299ca21b754eddacf8f3d10e5674cb93773288539010803a7024c339',
       i686: '9ddfd5b69486b7af2e07bb455136d60a412764d0e02839ca74baefe81ed55243',
     x86_64: '119c35a1e20179f9e1010e6b713209539e060d3fbd8c0f560aaa6e8d55499b00'
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
