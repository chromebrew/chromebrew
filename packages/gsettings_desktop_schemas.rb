require 'buildsystems/meson'

class Gsettings_desktop_schemas < Meson
  description 'Collection of GSettings schemas for GNOME desktop.'
  homepage 'https://gitlab.gnome.org/GNOME/gsettings-desktop-schemas'
  version '50.1'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gsettings-desktop-schemas.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e8e83600b2ffd1d4a126e9160b1dc916c263ddbe13c88566a5aa304da185d932',
     armv7l: 'e8e83600b2ffd1d4a126e9160b1dc916c263ddbe13c88566a5aa304da185d932',
     x86_64: '9919ac7be6fb7a8ed8b5bf34f90aaba7699fef21e9dad77586a7d209b0f9689f'
  })

  depends_on 'glib' => :build
  depends_on 'gobject_introspection' => :build

  gnome
end
