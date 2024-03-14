require 'buildsystems/meson'

class Gnome_nibbles < Meson
  description 'snake game, up to four players'
  homepage 'https://wiki.gnome.org/Apps/Nibbles'
  version '3.38.3'
  license 'GPL-3+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-nibbles.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '28a33cbfd5d4be568785cddbe7e6ea145d202911fb7c94803ca7098f7691cc55',
     armv7l: '28a33cbfd5d4be568785cddbe7e6ea145d202911fb7c94803ca7098f7691cc55',
     x86_64: '7439e1154d540af84ee1d755a672b790b0000e8158cdc16df618c72be4f61e2e'
  })

  depends_on 'clutter_gtk'
  depends_on 'desktop_file_utils' => :build
  depends_on 'gsound'
  depends_on 'libgnome_games_support'
  depends_on 'librsvg'
  depends_on 'vala' => :build
  depends_on 'wayland'

  gnome
end
