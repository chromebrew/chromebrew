require 'buildsystems/meson'

class Gnome_nibbles < Meson
  description 'snake game, up to four players'
  homepage 'https://wiki.gnome.org/Apps/Nibbles'
  version '4.5.2'
  license 'GPL-3+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-nibbles.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9660e5c1b93a8b4f27942938aabf4c0dc966f4ac6a75a03e21592ffaba00193d',
     armv7l: '9660e5c1b93a8b4f27942938aabf4c0dc966f4ac6a75a03e21592ffaba00193d',
     x86_64: '50bec6ffffb038aebc848e1dee9b649c22b57e82950ace8dcd543e7ecb0acf10'
  })

  depends_on 'cairo' # R
  depends_on 'clutter_gtk' => :build
  depends_on 'desktop_file_utils' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'gsound' => :executable
  depends_on 'gtk4' => :executable
  depends_on 'harfbuzz' # R
  depends_on 'libadwaita' => :executable
  depends_on 'libgee' => :executable
  depends_on 'libgnome_games_support' # R
  depends_on 'librsvg' => :build
  depends_on 'pango' => :executable
  depends_on 'py3_itstool' => :build
  depends_on 'vala' => :build
  depends_on 'wayland' => :build

  gnome
end
