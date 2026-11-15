require 'buildsystems/meson'

class Gsettings_desktop_schemas < Meson
  description 'Collection of GSettings schemas for GNOME desktop.'
  homepage 'https://gitlab.gnome.org/GNOME/gsettings-desktop-schemas'
  version '51.0'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gsettings-desktop-schemas.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd397c9cf7eb827f2a96bd176c6b813cff7c3bc2e6472c7dd67e244e6ea8652ce',
     armv7l: 'd397c9cf7eb827f2a96bd176c6b813cff7c3bc2e6472c7dd67e244e6ea8652ce',
     x86_64: '5e5de00d3be966c41fba5dfbd452e98ee98068f630f8f3cb679de9c925e0fddd'
  })

  depends_on 'glib' => :build
  depends_on 'gobject_introspection' => :build

  gnome
end
