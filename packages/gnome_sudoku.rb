require 'buildsystems/meson'

class Gnome_sudoku < Meson
  description 'Sudoku puzzle game for GNOME'
  homepage 'https://wiki.gnome.org/Apps/Sudoku'
  version '49.4'
  license 'GPL-3+ and CC-BY-SA-3.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-sudoku.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7a6bd99e2ec31d276634df30bad0e999cd57dcd460968e571fe1727a614262ec',
     armv7l: '7a6bd99e2ec31d276634df30bad0e999cd57dcd460968e571fe1727a614262ec',
     x86_64: 'd686849dfcf126224d2dfd9d846aadc9c36f4f0f1a0d6bfbb99c5dea1483d716'
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
  depends_on 'py3_itstool' => :build
  depends_on 'qqwing' # R

  gnome
end
