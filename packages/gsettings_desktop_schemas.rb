require 'package'

class Gsettings_desktop_schemas < Package
  description 'Collection of GSettings schemas for GNOME desktop.'
  homepage 'https://git.gnome.org/browse/gsettings-desktop-schemas'
  version '44.0'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gsettings-desktop-schemas.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gsettings_desktop_schemas/44.0_armv7l/gsettings_desktop_schemas-44.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gsettings_desktop_schemas/44.0_armv7l/gsettings_desktop_schemas-44.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gsettings_desktop_schemas/44.0_i686/gsettings_desktop_schemas-44.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gsettings_desktop_schemas/44.0_x86_64/gsettings_desktop_schemas-44.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '284c6121143978682e9907c5320afa6ad92fa2993359f79866fbbab283725072',
     armv7l: '284c6121143978682e9907c5320afa6ad92fa2993359f79866fbbab283725072',
       i686: '97291b9bc0a8debb7eae98439ffa31b610112889ab0b0610eca57dd44c107aef',
     x86_64: 'c2078cb7017606a95b92f0a7cec3fad17ed4fa8b2071b687d5293660ee40bec9'
  })

  # depends_on 'gnome_common'
  depends_on 'glib' => :build
  depends_on 'gobject_introspection' => :build
  # depends_on 'gtk4'

  def self.build
    system "mold -run meson setup #{CREW_MESON_OPTIONS} builddir"
    system 'meson configure --no-pager builddir'
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
