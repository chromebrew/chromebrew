require 'buildsystems/meson'

class Gnome_mines < Meson
  description 'GNOME Mines (formerly known as Gnomine) is minesweeper clone for GNOME'
  homepage 'https://wiki.gnome.org/Apps/Mines'
  version '40.1'
  license 'GPL-3+ and CC-BY-SA-3.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-mines.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bfedcf49e0df255d097cd6db7ed3e9bba0ece1d18e3205f88297c9fa92120e0b',
     armv7l: 'bfedcf49e0df255d097cd6db7ed3e9bba0ece1d18e3205f88297c9fa92120e0b',
     x86_64: '2d59a0cd39fe8afe0fc6e5303a940dd4c9b0a28b5e77ff0964ce8f30b513f165'
  })

  depends_on 'clutter_gtk' => :build
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gsound' => :build
  depends_on 'gtk3' # R
  depends_on 'libgnome_games_support' # R
  depends_on 'librsvg' => :build
  depends_on 'wayland' => :build

  gnome
  no_lto
end
