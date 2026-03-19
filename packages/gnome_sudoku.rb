require 'buildsystems/meson'

class Gnome_sudoku < Meson
  description 'Sudoku puzzle game for GNOME'
  homepage 'https://wiki.gnome.org/Apps/Sudoku'
  version '50.0'
  license 'GPL-3+ and CC-BY-SA-3.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-sudoku.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6766c8a5443a844e6e4e027df710d2b9d66407d82ff8a8c1d4e03e2875e4edf7',
     armv7l: '6766c8a5443a844e6e4e027df710d2b9d66407d82ff8a8c1d4e03e2875e4edf7',
     x86_64: '809be4a85edf82668e63b3e37968ad631f9873d2f6a58b9fe0b1bf31c765d8bb'
  })

  depends_on 'blueprint_compiler' => :build
  depends_on 'cairo' => :executable
  depends_on 'clutter_gtk' => :build
  depends_on 'desktop_file_utils' => :build
  depends_on 'gcc_lib' => :executable
  depends_on 'glib' => :executable
  depends_on 'glibc' => :executable
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
