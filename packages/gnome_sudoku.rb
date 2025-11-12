require 'buildsystems/meson'

class Gnome_sudoku < Meson
  description 'Sudoku puzzle game for GNOME'
  homepage 'https://wiki.gnome.org/Apps/Sudoku'
  version '49.2'
  license 'GPL-3+ and CC-BY-SA-3.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-sudoku.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f6b0745a03fbddc482287c44d620f91e4524e0c3e0b766646295796f4bb81246',
     armv7l: 'f6b0745a03fbddc482287c44d620f91e4524e0c3e0b766646295796f4bb81246',
     x86_64: '1b2ea31fd26f9e0d8a3281faaccacf35192681a1a9aab28b3cfa51b5aa9656ab'
  })

  depends_on 'blueprint_compiler' => :build
  depends_on 'cairo' # R
  depends_on 'clutter_gtk' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
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
