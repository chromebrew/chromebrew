require 'buildsystems/meson'

class Gnome_sudoku < Meson
  description 'Sudoku puzzle game for GNOME'
  homepage 'https://wiki.gnome.org/Apps/Sudoku'
  version '51.0.1'
  license 'GPL-3+ and CC-BY-SA-3.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-sudoku.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '82907c769b14277cfe748dbeb9001af9b94e8a5aa5f474d4485108bfd39fba3d',
     armv7l: '82907c769b14277cfe748dbeb9001af9b94e8a5aa5f474d4485108bfd39fba3d',
     x86_64: '5923ede414d18472ec7bcc6beb0db259c1d19ac57d3f90dea0ba64bc1ddafd6d'
  })

  depends_on 'blueprint_compiler' => :build
  depends_on 'cairo' => :executable
  depends_on 'clutter_gtk' => :build
  depends_on 'desktop_file_utils' => :build
  depends_on 'gcc_lib' => :executable
  depends_on 'glib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'gsound' => :build
  depends_on 'gtk4' => :executable
  depends_on 'harfbuzz' => :executable
  depends_on 'json_glib' => :executable
  depends_on 'libadwaita' => :executable
  depends_on 'libgee' => :executable
  depends_on 'librsvg' => :build
  depends_on 'pango' => :executable
  depends_on 'py3_itstool' => :build
  depends_on 'qqwing' => :executable

  gnome
end
