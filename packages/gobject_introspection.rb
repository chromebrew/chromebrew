require 'package'

class Gobject_introspection < Package
  description 'GObject introspection is a middleware layer between C libraries (using GObject) and language bindings.'
  homepage 'https://wiki.gnome.org/action/show/Projects/GObjectIntrospection'
  version '1.66.1'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/gobject-introspection/1.66/gobject-introspection-1.66.1.tar.xz'
  source_sha256 'dd44a55ee5f426ea22b6b89624708f9e8d53f5cc94e5485c15c87cb30e06161d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gobject_introspection-1.66.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gobject_introspection-1.66.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gobject_introspection-1.66.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gobject_introspection-1.66.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '32ff02babe0624b822bc71f0405d6db9babc276af4d24660af3eb703f9d7959c',
     armv7l: '32ff02babe0624b822bc71f0405d6db9babc276af4d24660af3eb703f9d7959c',
       i686: 'e63d47a08feefa228e260fd3dd13cae6f85f38c96942b487abdf3f6a6076bc13',
     x86_64: 'adb621c7edcc29dc653140bd07260270eead0ca8fb26e063ff9788c098c7dfab',
  })

  depends_on 'glib'

  def self.build
    system "meson --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
