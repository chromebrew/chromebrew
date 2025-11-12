require 'buildsystems/meson'

class Gnome_nibbles < Meson
  description 'snake game, up to four players'
  homepage 'https://wiki.gnome.org/Apps/Nibbles'
  version '4.4.2'
  license 'GPL-3+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-nibbles.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9387c9f62e9616327b77edc6decb894fb903c7b9936330d9c6c5a3597894eee6',
     armv7l: '9387c9f62e9616327b77edc6decb894fb903c7b9936330d9c6c5a3597894eee6',
     x86_64: '214a1d36a89ba55ed4cfaada7b6d95c6d462fc448930fc58cfa254be03689790'
  })

  depends_on 'clutter_gtk' => :build
  depends_on 'desktop_file_utils' => :build
  depends_on 'gsound' => :build
  depends_on 'libadwaita' => :build
  depends_on 'librsvg' => :build
  depends_on 'vala' => :build
  depends_on 'wayland' => :build
  depends_on 'cairo' # R
  depends_on 'harfbuzz' # R
  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gsound' # R
  depends_on 'gtk4' # R
  depends_on 'libgee' # R
  depends_on 'libgnome_games_support' # R
  depends_on 'pango' # R
  depends_on 'py3_itstool' => :build

  gnome
end
