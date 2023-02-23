require 'package'

class Gsettings_desktop_schemas < Package
  description 'Collection of GSettings schemas for GNOME desktop.'
  homepage 'https://git.gnome.org/browse/gsettings-desktop-schemas'
  @_ver = '44.beta'
  version @_ver
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gsettings-desktop-schemas.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gsettings_desktop_schemas/44.beta_armv7l/gsettings_desktop_schemas-44.beta-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gsettings_desktop_schemas/44.beta_armv7l/gsettings_desktop_schemas-44.beta-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gsettings_desktop_schemas/44.beta_i686/gsettings_desktop_schemas-44.beta-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gsettings_desktop_schemas/44.beta_x86_64/gsettings_desktop_schemas-44.beta-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '3dc0496c2be85936884bd6841b2136add5aa883eec33926fadd6ac4358b46f8e',
     armv7l: '3dc0496c2be85936884bd6841b2136add5aa883eec33926fadd6ac4358b46f8e',
       i686: '4e9ac1a1ef5a84f66c39bd3390a96757353df6e4a8b5d935e620674ad8575008',
     x86_64: '0e3f608fde5304b2f75897f6016990add9900434a0e64264f9d1c245f91288bc'
  })

  # depends_on 'gnome_common'
  depends_on 'glib' => :build
  depends_on 'gobject_introspection' => :build
  # depends_on 'gtk4'

  gnome

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.postinstall
    system "glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas/"
  end
end
