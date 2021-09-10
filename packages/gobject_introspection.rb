require 'package'

class Gobject_introspection < Package
  description 'GObject introspection is a middleware layer between C libraries (using GObject) and language bindings.'
  homepage 'https://wiki.gnome.org/action/show/Projects/GObjectIntrospection'
  @_ver = '1.69.0'
  version @_ver
  license 'LGPL-2+ and GPL-2+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gobject-introspection.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gobject_introspection/1.69.0_armv7l/gobject_introspection-1.69.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gobject_introspection/1.69.0_armv7l/gobject_introspection-1.69.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gobject_introspection/1.69.0_i686/gobject_introspection-1.69.0-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gobject_introspection/1.69.0_x86_64/gobject_introspection-1.69.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'f07dcf8fa48c6fcd1bc08cf03dad0ee605c2dd78c939221971ae2e8b8950f7f3',
     armv7l: 'f07dcf8fa48c6fcd1bc08cf03dad0ee605c2dd78c939221971ae2e8b8950f7f3',
       i686: '7f7e4d8121131dbe3ee06006dce70e24fa84198aaea0d13d7f3f4e9d65af1af4',
     x86_64: '2c3a734c15234a2d9fc7891b80ab65e6d11e7cca4275256b173a1d85fecc5c8c'
  })

  depends_on 'glib'

  def self.build
    system "#{CREW_ENV_OPTIONS} meson #{CREW_MESON_OPTIONS} \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
