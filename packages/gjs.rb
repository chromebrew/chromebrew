require 'package'

class Gjs < Package
  description 'Javascript Bindings for GNOME'
  version '1.67.2'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/gjs/1.67/gjs-1.67.2.tar.xz'
  source_sha256 '4d9a4b8580a6871239e227338e3bc54f7d119057306fec56a364d90da69e1ce6'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gjs-1.67.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gjs-1.67.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gjs-1.67.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gjs-1.67.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'db807d23b09a122d9ffd02699cc301f4b6aa5668076d610c45cf4c6f1bf981c6',
     armv7l: 'db807d23b09a122d9ffd02699cc301f4b6aa5668076d610c45cf4c6f1bf981c6',
       i686: '8377ad2a8e958df5fa9182f0d0a7138e22ca82a814c9bc4ba265d5edf55a55cb',
     x86_64: 'e5d3274313176202aee2dbf0fc2d2c4277be1bde67f93d5e9b10c0d3fac20dd5'
  })

  depends_on 'cairo'
  depends_on 'gobject_introspection'
  depends_on 'js78'
  depends_on 'dconf'
  depends_on 'gobject_introspection' => ':build'
  depends_on 'dbus' => ':build'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    -Dinstalled_tests=false \
    -Dskip_dbus_tests=true \
    -Dreadline=disabled \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
