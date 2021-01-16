require 'package'

class Pygobject < Package
  description 'PyGObject is a Python package which provides bindings for GObject based libraries such as GTK+, GStreamer, WebKitGTK+, GLib, GIO and many more.'
  homepage 'https://pygobject.readthedocs.io/en/latest/'
  version '3.38-0a16'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/pygobject/-/archive/0a16082c3e092fdccf5499172a4b9dec07aa383d/pygobject-0a16082c3e092fdccf5499172a4b9dec07aa383d.tar.bz2'
  source_sha256 'f83531eeb2d4980afde618a83d16749b14e47d92673a6b1ec63ae7a0a01c4bfc'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pygobject-3.38-0a16-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pygobject-3.38-0a16-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/pygobject-3.38-0a16-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pygobject-3.38-0a16-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '25288827bdc2116b0afabca5b4016a3d53feb884dbb4514281e1ac2eb50212bb',
      armv7l: '25288827bdc2116b0afabca5b4016a3d53feb884dbb4514281e1ac2eb50212bb',
        i686: 'e85370c34c4beb590b8bf9695dfcbc8107b958d37fec6a49d39c445b30e7cfc2',
      x86_64: '65a8a2138b1ddae9cf90782515295577219bee5e26c41f3285077d92ddffd10f',
  })

  depends_on 'glib'
  depends_on 'gobject_introspection'
  depends_on 'pycairo'

  def self.build
    system 'pip3 install --upgrade pycairo'
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
    system 'pip3 uninstall --yes pycairo'
    system "pip3 install pycairo --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX}"
  end
end
