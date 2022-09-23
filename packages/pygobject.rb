require 'package'

class Pygobject < Package
  description 'PyGObject is a Python package which provides bindings for GObject based libraries such as GTK+, GStreamer, WebKitGTK+, GLib, GIO and many more.'
  homepage 'https://pygobject.readthedocs.io/'
  @_ver = '3.42.2'
  version @_ver.to_s
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/pygobject.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pygobject/3.42.2_armv7l/pygobject-3.42.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pygobject/3.42.2_armv7l/pygobject-3.42.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pygobject/3.42.2_i686/pygobject-3.42.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pygobject/3.42.2_x86_64/pygobject-3.42.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '0f0bd117ff285b72db15d479ce21676e7931a87e20430d94f4f5c1b4bacf3c4a',
     armv7l: '0f0bd117ff285b72db15d479ce21676e7931a87e20430d94f4f5c1b4bacf3c4a',
       i686: '819f11aa7a9230417860c66fc39d348ffdf4a103939b5143ed64fd32e442997f',
     x86_64: 'd51378dfb0c2b7124a178d15a318a2184851f08ba1421ed40d8ed674f839c07c'
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
