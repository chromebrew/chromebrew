require 'buildsystems/meson'

class Gsettings_desktop_schemas < Meson
  description 'Collection of GSettings schemas for GNOME desktop.'
  homepage 'https://git.gnome.org/browse/gsettings-desktop-schemas'
  version '46.rc'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/gsettings-desktop-schemas.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '503ad8e48cc72c97beb135b2e9b27b01a90ff18a10cef4c9d05f2c8c1f2feb04',
     armv7l: '503ad8e48cc72c97beb135b2e9b27b01a90ff18a10cef4c9d05f2c8c1f2feb04',
     x86_64: '4aee4c66f8b9db262fe88d105ea5d07d007e83c5439ffc1e66a387a279f97058'
  })

  depends_on 'glib' => :build
  depends_on 'gobject_introspection' => :build

  gnome
end
