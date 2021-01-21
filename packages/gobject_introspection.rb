require 'package'

class Gobject_introspection < Package
  description 'GObject introspection is a middleware layer between C libraries (using GObject) and language bindings.'
  homepage 'https://wiki.gnome.org/action/show/Projects/GObjectIntrospection'
  version '1.66.1-2'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/gobject-introspection/1.66/gobject-introspection-1.66.1.tar.xz'
  source_sha256 'dd44a55ee5f426ea22b6b89624708f9e8d53f5cc94e5485c15c87cb30e06161d'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gobject_introspection-1.66.1-2-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gobject_introspection-1.66.1-2-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/gobject_introspection-1.66.1-2-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gobject_introspection-1.66.1-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '3628085f0787c7b525307f6da6aa27d2422315b53e0e201f7f8d1567a09dce4b',
      armv7l: '3628085f0787c7b525307f6da6aa27d2422315b53e0e201f7f8d1567a09dce4b',
        i686: '5e2b0ab9f9df8a749b83a0801e329579f29ad3c76c34086a47019499b38412fd',
      x86_64: '45cf5b99b8a7b5d9c60e4e5310ce3ee447cbebb331b6a54f9ef43ec7c59f4826',
  })

  depends_on 'glib'

  def self.build
    system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} \
    meson #{CREW_MESON_OPTIONS} \
    -Dc_args='-fuse-ld=lld' \
    -Dcpp_args='-fuse-ld=lld' \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
