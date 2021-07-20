require 'package'

class Gsettings_desktop_schemas < Package
  description 'Collection of GSettings schemas for GNOME desktop.'
  homepage 'https://git.gnome.org/browse/gsettings-desktop-schemas'
  @_ver = '40.0'
  version @_ver
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://gitlab.gnome.org/GNOME/gsettings-desktop-schemas/-/archive/#{@_ver}/gsettings-desktop-schemas-#{@_ver}.tar.bz2"
  source_sha256 'ce1d57e98ba6e460f9764e4a48a28ebe1866423e54c1eeceff6a3c90feb41bc6'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gsettings_desktop_schemas/40.0_armv7l/gsettings_desktop_schemas-40.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gsettings_desktop_schemas/40.0_armv7l/gsettings_desktop_schemas-40.0-chromeos-armv7l.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gsettings_desktop_schemas/40.0_x86_64/gsettings_desktop_schemas-40.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '2b7288bf9e021ae99686f1a09521154c1e12f8ccb6e370797fe345c729e80c76',
     armv7l: '2b7288bf9e021ae99686f1a09521154c1e12f8ccb6e370797fe345c729e80c76',
     x86_64: 'dc5237b94506cbf20080be7d1af759053dbdabde617329f08714a849eb4fc7c3'
  })

  depends_on 'gnome_common'
  depends_on 'glib'
  depends_on 'gobject_introspection'
  depends_on 'gtk4'

  def self.build
    system "meson #{CREW_MESON_OPTIONS} builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.postinstall
    system "glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas"
  end
end
