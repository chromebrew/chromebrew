require 'package'

class Gobject_introspection < Package
  description 'GObject introspection is a middleware layer between C libraries (using GObject) and language bindings.'
  homepage 'https://wiki.gnome.org/action/show/Projects/GObjectIntrospection'
  @_ver = '1.70.0'
  version @_ver
  license 'LGPL-2+ and GPL-2+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gobject-introspection.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gobject_introspection/1.70.0_armv7l/gobject_introspection-1.70.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gobject_introspection/1.70.0_armv7l/gobject_introspection-1.70.0-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gobject_introspection/1.70.0_x86_64/gobject_introspection-1.70.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '565722c56f84a00895ca6494d8f69f516144b856e279bb05396164c69ccef29e',
     armv7l: '565722c56f84a00895ca6494d8f69f516144b856e279bb05396164c69ccef29e',
     x86_64: '39c49dab939116d75c8009bfe803d686273c371bf1774b034e39b070ef08907c'
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
