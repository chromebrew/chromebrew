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
    aarch64: '219b50c913e39c48504ce108543ba058ab339269471f8b1304a876da688b2d53',
     armv7l: '219b50c913e39c48504ce108543ba058ab339269471f8b1304a876da688b2d53',
     x86_64: '6dd7b193399288c6ce36f4a179461859478fede70664cd39754d99cd6f39c306'
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
