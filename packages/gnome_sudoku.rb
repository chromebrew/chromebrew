require 'buildsystems/meson'

class Gnome_sudoku < Meson
  description 'Sudoku puzzle game for GNOME'
  homepage 'https://wiki.gnome.org/Apps/Sudoku'
  version '46.0'
  license 'GPL-3+ and CC-BY-SA-3.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-sudoku.git'
  git_hashtag version
  binary_compression 'tar.zst'

  depends_on 'clutter_gtk' => :build
  depends_on 'gsound' => :build
  depends_on 'librsvg' => :build
  depends_on 'qqwing' => :build

  gnome
end
