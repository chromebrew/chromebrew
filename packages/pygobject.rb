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
     aarch64: '5124d5109eb258b51096120bbe3a3c56cb0e7d8cc2a5489ff88f24ac09cc790c',
      armv7l: '5124d5109eb258b51096120bbe3a3c56cb0e7d8cc2a5489ff88f24ac09cc790c',
        i686: '2fe8b9a1e55979e386c4e828eac1bb291c5fdce811c6c4ef506bd6aa112d6b5f',
      x86_64: 'f0ce44968f0f7bf36dfe99484a97965ab66530f120b47a789a7c58cdfe43c1cf',
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
  end
end
