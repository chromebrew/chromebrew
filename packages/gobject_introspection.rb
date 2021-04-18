require 'package'

class Gobject_introspection < Package
  description 'GObject introspection is a middleware layer between C libraries (using GObject) and language bindings.'
  homepage 'https://wiki.gnome.org/action/show/Projects/GObjectIntrospection'
  @_ver = '1.68.0'
  version @_ver
  license 'LGPL-2+ and GPL-2+'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/gobject-introspection/-/archive/#{@_ver}/gobject-introspection-#{@_ver}.tar.bz2"
  source_sha256 'b22035bd3e7ea27cc29b0c19ec5da8dd6cafe88a08392ecd06b41d4025406b4c'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/gobject_introspection-1.68.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/gobject_introspection-1.68.0-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/gobject_introspection-1.68.0-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/gobject_introspection-1.68.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '7f19992ebfb2efd6890b80aa13975b5052b62018359dfd3d6d4f504d88f5cfb8',
     armv7l: '7f19992ebfb2efd6890b80aa13975b5052b62018359dfd3d6d4f504d88f5cfb8',
       i686: '8b65be9e83ef90cd7442c1bc0fa54f7e781cd77193eea98550bcb9f98ba044a1',
     x86_64: 'c150f71e67bb0dcb9f00b9d22442bc572097c6c2612725d56dd7537bb7619402'
  })

  depends_on 'glib'

  def self.build
    system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} \
    meson #{CREW_MESON_OPTIONS} \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
