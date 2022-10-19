require 'package'

class Gsettings_desktop_schemas < Package
  description 'Collection of GSettings schemas for GNOME desktop.'
  homepage 'https://git.gnome.org/browse/gsettings-desktop-schemas'
  @_ver = '43.0'
  version @_ver
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gsettings-desktop-schemas.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gsettings_desktop_schemas/43.0_armv7l/gsettings_desktop_schemas-43.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gsettings_desktop_schemas/43.0_armv7l/gsettings_desktop_schemas-43.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gsettings_desktop_schemas/43.0_i686/gsettings_desktop_schemas-43.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gsettings_desktop_schemas/43.0_x86_64/gsettings_desktop_schemas-43.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'baa1861484b9291c7a1c22e22dd08478689907564f6947cc97e8f30cb2cc4d44',
     armv7l: 'baa1861484b9291c7a1c22e22dd08478689907564f6947cc97e8f30cb2cc4d44',
       i686: '6ccf93dcbfd48dc7d43f4a2a115ab4eae1a6238916868e068726cdcee259e908',
     x86_64: '6df95b4f1cea0c2ffcb39a606ddb87686a15f682f7777bc35ae68793cea1e371'
  })

  depends_on 'gnome_common'
  depends_on 'glib'
  depends_on 'gobject_introspection'
  depends_on 'gtk4'

  gnome

  def self.build
    system "meson #{CREW_MESON_OPTIONS} builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
