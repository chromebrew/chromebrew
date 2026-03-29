require 'buildsystems/meson'

class Libgedit_gfls < Meson
  description 'A module dedicated to file loading and saving.'
  homepage 'https://gitlab.gnome.org/World/gedit/libgedit-gfls'
  version '0.4.0'
  license 'LGPL-3.0-or-later'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/World/gedit/libgedit-gfls.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'abb572598ee74eba5144a9c709b71340c9d2912a76a4b7655398ab08dceaa5be',
     armv7l: 'abb572598ee74eba5144a9c709b71340c9d2912a76a4b7655398ab08dceaa5be',
     x86_64: '08ba1ff4a136b977b09d8aae365d751cef64fbca1a696726029a44042bd9416d'
  })

  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'gobject_introspection'
  depends_on 'gtk3'

  meson_options '-Dgtk_doc=false'
end
