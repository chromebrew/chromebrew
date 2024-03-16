require 'buildsystems/meson'

class Gnome_mines < Meson
  description 'GNOME Mines (formerly known as Gnomine) is minesweeper clone for GNOME'
  homepage 'https://wiki.gnome.org/Apps/Mines'
  version '40.1'
  license 'GPL-3+ and CC-BY-SA-3.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-mine.git'
  git_hashtag version
  binary_compression 'tar.zst'

  depends_on 'clutter_gtk' => :build
  depends_on 'gsound' => :build
  depends_on 'librsvg' => :build
  depends_on 'libgnome_games_support' => :build
  depends_on 'wayland' => :build

  gnome
  no_lto
end
