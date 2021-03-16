require 'package'

class Gobject_introspection < Package
  description 'GObject introspection is a middleware layer between C libraries (using GObject) and language bindings.'
  homepage 'https://wiki.gnome.org/action/show/Projects/GObjectIntrospection'
  version '1.67.1'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/gobject-introspection/1.66/gobject-introspection-1.66.1.tar.xz'
  source_sha256 'dd44a55ee5f426ea22b6b89624708f9e8d53f5cc94e5485c15c87cb30e06161d'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gobject_introspection-1.67.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gobject_introspection-1.67.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gobject_introspection-1.67.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gobject_introspection-1.67.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '4da5e9d81d858f5d62f3923656c0ede85615ec6a013553d68c94b6108e0642fb',
     armv7l: '4da5e9d81d858f5d62f3923656c0ede85615ec6a013553d68c94b6108e0642fb',
       i686: '7e6e6507aaf64cd48f9f5a99b5d0c9aa983e5c05dccaf29c2437e497e9509ae8',
     x86_64: '72db415a3796c08d212a0dbd9a1c32c2c1318ac379189b6411df383eac8f8724'
  })

  depends_on 'glib'

  def self.build
    system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} \
    meson #{CREW_MESON_LTO_OPTIONS} \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
