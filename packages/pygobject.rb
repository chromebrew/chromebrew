require 'package'

class Pygobject < Package
  description 'PyGObject is a Python package which provides bindings for GObject based libraries such as GTK+, GStreamer, WebKitGTK+, GLib, GIO and many more.'
  homepage 'https://pygobject.readthedocs.io/en/latest/'
  version '3.28.3'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/e0/e8/1e4f21800015a9ca153969e85fc29f7962f8f82fc5dbc1ecbdeb9dc54c75/PyGObject-3.28.3.tar.gz'
  source_sha256 '250fb669b6ac64eba034cc4404fcbcc993717b1f77c29dff29f8c9202da20d55'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pygobject-3.28.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pygobject-3.28.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pygobject-3.28.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pygobject-3.28.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'debfe80135a4917e2524b6c88697dc4355947ee31f3e4ab3944d977e1896ad77',
     armv7l: 'debfe80135a4917e2524b6c88697dc4355947ee31f3e4ab3944d977e1896ad77',
       i686: '057cb85a474ab991cdc114d053d002aca8f5aa0c2bc9d80d1f1b9daf1a301930',
     x86_64: '0f86300f12024061df08f2e59618f06cedcd284d8acb69b1186b4dc3d2d5a727',
  })

  depends_on 'glib'
  depends_on 'gobject_introspection'
  depends_on 'pycairo'

  def self.build
    system "python2.7 setup.py build"
    system "python3 setup.py build"
  end

  def self.install
    system "python2.7 setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
    system "python3 setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end
