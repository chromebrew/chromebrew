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
    aarch64: '2bd792a903c09a81c5eba9507767d3c2084ab0b89fd98d9b015b5c401285e88d',
     armv7l: '2bd792a903c09a81c5eba9507767d3c2084ab0b89fd98d9b015b5c401285e88d',
     x86_64: 'fe86343441cbca7b82c36f07623a3ebf77a4b8dbb967dba310244715c7d6a2a6'
  })

  depends_on 'glib' => :build
  depends_on 'gobject_introspection' => :build

  gnome
end
