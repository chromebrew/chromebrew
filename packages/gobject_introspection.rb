require 'package'

class Gobject_introspection < Package
  description 'GObject introspection is a middleware layer between C libraries (using GObject) and language bindings.'
  homepage 'https://wiki.gnome.org/action/show/Projects/GObjectIntrospection'
  @_ver = '1.67.1'
  version @_ver
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/gobject-introspection/-/archive/#{@_ver}/gobject-introspection-#{@_ver}.tar.bz2"
  source_sha256 '4cd840eb3a9b5f6cddda96f79e9f186b1da4b93343a0c82e0ab185beccb25a6b'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gobject_introspection-1.67.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gobject_introspection-1.67.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gobject_introspection-1.67.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gobject_introspection-1.67.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '07f5085fba9f5d6ef6ad5be8f19d977b27a4ba869819f92fd52d230c6b68cfb4',
     armv7l: '07f5085fba9f5d6ef6ad5be8f19d977b27a4ba869819f92fd52d230c6b68cfb4',
       i686: '277e24570f9dccdc644e5398ca92538af71cbedcf000b61eb702f4563071ebe2',
     x86_64: '845bce3214bddc6008d384f31efb210578aa97e4b50dff9017aa12b54f8a2963'
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
