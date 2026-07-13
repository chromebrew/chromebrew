require 'buildsystems/meson'

class Gnome_sudoku < Meson
  description 'Sudoku puzzle game for GNOME'
  homepage 'https://wiki.gnome.org/Apps/Sudoku'
  version '50.3'
  license 'GPL-3+ and CC-BY-SA-3.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-sudoku.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1e752e32ff88b69ba927f13ddf5fa8d9755e489094b1b086db412c23ae0fef32',
     armv7l: '1e752e32ff88b69ba927f13ddf5fa8d9755e489094b1b086db412c23ae0fef32',
     x86_64: 'a8b4f5e61410416159a3a7b0bc9fc23fbcf3627a6fc3fa2321824c98f4cac8df'
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
