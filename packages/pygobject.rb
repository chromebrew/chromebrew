require 'package'

class Pygobject < Package
  description 'PyGObject is a Python package which provides bindings for GObject based libraries such as GTK+, GStreamer, WebKitGTK+, GLib, GIO and many more.'
  homepage 'https://pygobject.readthedocs.io/'
  @_ver = '3.44.1'
  version "#{@_ver}-py3.11"
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/pygobject.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pygobject/3.44.1-py3.11_armv7l/pygobject-3.44.1-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pygobject/3.44.1-py3.11_armv7l/pygobject-3.44.1-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pygobject/3.44.1-py3.11_i686/pygobject-3.44.1-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pygobject/3.44.1-py3.11_x86_64/pygobject-3.44.1-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2ef873543b7493be84c95a9f9991bf00b06c244603086cca762e6f67dd04f130',
     armv7l: '2ef873543b7493be84c95a9f9991bf00b06c244603086cca762e6f67dd04f130',
       i686: 'e3d27cd0f68ecb35513bcd6476d9accbaabfc4cbc2dbfd77a319fefa069b969f',
     x86_64: 'b8cd3b017da2a8b5c20eadbd5423096a79d5772a88141f039b2e34dc7bd42a93'
  })

  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' # R
  depends_on 'harfbuzz' # R
  depends_on 'libffi' # R
  depends_on 'py3_pycairo' => :build
  depends_on 'python3' # R
  depends_on 'wayland' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
