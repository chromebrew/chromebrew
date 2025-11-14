require 'buildsystems/meson'

class Gsettings_desktop_schemas < Meson
  description 'Collection of GSettings schemas for GNOME desktop.'
  homepage 'https://gitlab.gnome.org/GNOME/gsettings-desktop-schemas'
  version '49.1'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gsettings-desktop-schemas.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1c8f2304e59ab7e4e7ae2c9c7b520e1d34ddb1b07e5bacd186d4a829a8a3278d',
     armv7l: '1c8f2304e59ab7e4e7ae2c9c7b520e1d34ddb1b07e5bacd186d4a829a8a3278d',
     x86_64: '758f514a162cb803e129424cc0be2209f8c01d443adba472149cde69c29601a2'
  })

  depends_on 'glib' => :build
  depends_on 'gobject_introspection' => :build

  gnome
end
