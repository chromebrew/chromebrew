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
    aarch64: '494d92427dae73271f0a4f698f1742b0f07fa8eee0bbc906074b2e5c0338b93c',
     armv7l: '494d92427dae73271f0a4f698f1742b0f07fa8eee0bbc906074b2e5c0338b93c',
     x86_64: '38bd142611bb3afb4e05e58b33ceb41d9a1d03b329dd261351ef41e023aa2e86'
  })

  depends_on 'blueprint_compiler' => :build
  depends_on 'cairo' # R
  depends_on 'clutter_gtk' => :build
  depends_on 'desktop_file_utils' => :build
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
