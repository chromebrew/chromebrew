require 'package'

class Gobject_introspection < Package
  description 'GObject introspection is a middleware layer between C libraries (using GObject) and language bindings.'
  homepage 'https://wiki.gnome.org/action/show/Projects/GObjectIntrospection'
  version '1.66.1-3'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/gobject-introspection/1.66/gobject-introspection-1.66.1.tar.xz'
  source_sha256 'dd44a55ee5f426ea22b6b89624708f9e8d53f5cc94e5485c15c87cb30e06161d'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gobject_introspection-1.66.1-3-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gobject_introspection-1.66.1-3-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/gobject_introspection-1.66.1-3-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gobject_introspection-1.66.1-3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'e4e2c7666bb7887a4af92b83140abfc6f68f9113bc3ce28b93cbf1760abcbe76',
      armv7l: 'e4e2c7666bb7887a4af92b83140abfc6f68f9113bc3ce28b93cbf1760abcbe76',
        i686: 'd5b61a8cbb54d82302cd45515cc20fd795887aa5209cb787c76bb626d034659d',
      x86_64: '726f495ff2e741e7066badf37da5decb29fef37886bebdd2ac5ea4ec2beb54b2',
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
