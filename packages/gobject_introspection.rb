require 'package'

class Gobject_introspection < Package
  description 'GObject introspection is a middleware layer between C libraries (using GObject) and language bindings.'
  homepage 'https://wiki.gnome.org/action/show/Projects/GObjectIntrospection'
  version '1.66.1-1'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/gobject-introspection/1.66/gobject-introspection-1.66.1.tar.xz'
  source_sha256 'dd44a55ee5f426ea22b6b89624708f9e8d53f5cc94e5485c15c87cb30e06161d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gobject_introspection-1.66.1-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gobject_introspection-1.66.1-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gobject_introspection-1.66.1-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gobject_introspection-1.66.1-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1aad738ef27dad976f69f79682b27ed57fb1a8005c495cf743badfcf86ee2c52',
     armv7l: '1aad738ef27dad976f69f79682b27ed57fb1a8005c495cf743badfcf86ee2c52',
       i686: '92437ff31a46c7a54bf86c17a98d9accd43f3096d3276cc4bd7fe0def389c93a',
     x86_64: '9ae418f953bc4985940c065c5c6264b106e87af0841b43c716d91566869784b2',
  })

  depends_on 'glib'

  ENV['CFLAGS'] = '-fuse-ld=lld'
  ENV['CXXFLAGS'] = '-fuse-ld=lld'

  def self.build
    system "meson #{CREW_MESON_OPTIONS} builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
