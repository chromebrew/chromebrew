require 'package'

class Pygobject < Package
  description 'PyGObject is a Python package which provides bindings for GObject based libraries such as GTK+, GStreamer, WebKitGTK+, GLib, GIO and many more.'
  homepage 'https://pygobject.readthedocs.io/en/latest/'
  version '3.38'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/pygobject/-/archive/pygobject-3-38/pygobject-pygobject-3-38.tar.bz2'
  source_sha256 '460b525c3763b78fc535f16f7ef24e51339ff112bc457e5a252a8afd7ecfcf9d'


  depends_on 'glib'
  depends_on 'gobject_introspection'
  depends_on 'pycairo'

  def self.build
    system "python3 setup.py build"
  end

  def self.install
    system "python3 setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end
