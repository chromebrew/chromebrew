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

  binary_sha256({
    aarch64: '312d7f69c755412d68c0996bd3b165714f6140a03e0085d7ee07db72d5481864',
     armv7l: '312d7f69c755412d68c0996bd3b165714f6140a03e0085d7ee07db72d5481864',
     x86_64: 'cf7973ad00562200aeb5527ce60cd4747fd737b6a9bc71b03a3e9b687e713ee5'
  })

  depends_on 'cairo' # R
  depends_on 'clutter_gtk' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'graphene' # R
  depends_on 'gsound' => :build
  depends_on 'gtk4' # R
  depends_on 'harfbuzz' # R
  depends_on 'json_glib' # R
  depends_on 'libadwaita' # R
  depends_on 'libgee' # R
  depends_on 'librsvg' => :build
  depends_on 'pango' # R
  depends_on 'qqwing' # R

  gnome
end
