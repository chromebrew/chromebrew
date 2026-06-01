require 'buildsystems/meson'

class Gnome_mines < Meson
  description 'GNOME Mines (formerly known as Gnomine) is minesweeper clone for GNOME'
  homepage 'https://wiki.gnome.org/Apps/Mines'
  version '50.0'
  license 'GPL-3+ and CC-BY-SA-3.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-mines.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8e9b521a87af43f0c2cf5f5ad5df9767dfb724c46d53d71af531d862cad50466',
     armv7l: '8e9b521a87af43f0c2cf5f5ad5df9767dfb724c46d53d71af531d862cad50466',
     x86_64: 'e566702d5da2c0aa2336cbeafd4d1044fbd9a9fb2cb41e4a1e69c04d1e0a5e9e'
  })

  depends_on 'clutter_gtk' => :build
  depends_on 'desktop_file_utils' => :build
  depends_on 'glib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'gsound' => :build
  depends_on 'gtk4' => :executable
  depends_on 'libadwaita' => :executable
  depends_on 'libgee' => :executable
  depends_on 'librsvg' => :build
  depends_on 'py3_itstool' => :build
  depends_on 'vala' => :build
  depends_on 'wayland' => :build

  gnome
  no_lto
end
