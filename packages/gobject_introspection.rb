require 'package'

class Gobject_introspection < Package
  description 'GObject introspection is a middleware layer between C libraries (using GObject) and language bindings.'
  homepage 'https://wiki.gnome.org/action/show/Projects/GObjectIntrospection'
  version '1.66.1-1'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/gobject-introspection/1.66/gobject-introspection-1.66.1.tar.xz'
  source_sha256 'dd44a55ee5f426ea22b6b89624708f9e8d53f5cc94e5485c15c87cb30e06161d'

  depends_on 'glib'

  ENV['CFLAGS'] = "-fuse-ld=lld"
  ENV['CXXFLAGS'] = "-fuse-ld=lld"
    
  def self.build
    system "meson #{CREW_MESON_OPTIONS} builddir"
    system "meson configure builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
