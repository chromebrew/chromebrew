require 'package'

class Gobject_introspection < Package
  description 'GObject introspection is a middleware layer between C libraries (using GObject) and language bindings.'
  homepage 'https://wiki.gnome.org/action/show/Projects/GObjectIntrospection'
  @_ver = '1.73.0'
  version @_ver.to_s
  license 'LGPL-2+ and GPL-2+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gobject-introspection.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gobject_introspection/1.73.0_armv7l/gobject_introspection-1.73.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gobject_introspection/1.73.0_armv7l/gobject_introspection-1.73.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gobject_introspection/1.73.0_i686/gobject_introspection-1.73.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gobject_introspection/1.73.0_x86_64/gobject_introspection-1.73.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7314c1f2b339c804ae2a2f6d6796bdc0e7dcc100ef6996e0da1f1543dc95c008',
     armv7l: '7314c1f2b339c804ae2a2f6d6796bdc0e7dcc100ef6996e0da1f1543dc95c008',
       i686: '51d59a3021eebc098d69cbff7e895743bf66c0f04b180fa78af3273e418b8249',
     x86_64: '8ae83a1eee02a8f95c6d95be86ac44420eb4008a03df1bcce3fd13677d103cda'
  })

  depends_on 'glib'

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
