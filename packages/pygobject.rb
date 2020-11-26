require 'package'

class Pygobject < Package
  description 'PyGObject is a Python package which provides bindings for GObject based libraries such as GTK+, GStreamer, WebKitGTK+, GLib, GIO and many more.'
  homepage 'https://pygobject.readthedocs.io/en/latest/'
  version '3.38'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/pygobject/-/archive/pygobject-3-38/pygobject-pygobject-3-38.tar.bz2'
  source_sha256 '460b525c3763b78fc535f16f7ef24e51339ff112bc457e5a252a8afd7ecfcf9d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pygobject-3.38-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pygobject-3.38-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pygobject-3.38-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pygobject-3.38-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '85c923964fcc0cfe03930ba133087e6eb2e1a1409f35d2641e57d8e63237c973',
     armv7l: '85c923964fcc0cfe03930ba133087e6eb2e1a1409f35d2641e57d8e63237c973',
       i686: '95563888d6b078754ab1057510c05d88fc554b616b7082cec5a12fdd14df1582',
     x86_64: '24f6390e2b45414e33558fadbf82d12e409ee4341f44e121e15463d87943e6b2',
  })


  depends_on 'glib'
  depends_on 'gobject_introspection'
  depends_on 'pycairo'

  def self.build
    system 'pip install pycairo'
    system "python3 setup.py build"
  end

  def self.install
    system "python3 setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
    system 'pip uninstall --yes pycairo'
    system "pip install pycairo --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX}"
  end
end
