require 'buildsystems/meson'

class Gnome_nibbles < Meson
  description 'snake game, up to four players'
  homepage 'https://wiki.gnome.org/Apps/Nibbles'
  version '4.0.3'
  license 'GPL-3+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-nibbles.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fd2904863d68384f2ba9b0b91b4ca3b973fd641a153dc942a9678565d1c56f21',
     armv7l: 'fd2904863d68384f2ba9b0b91b4ca3b973fd641a153dc942a9678565d1c56f21',
     x86_64: '3b68f82b64471b8fd51fe3cd744f7b9e6102ad993fc4bccb45416fb3f1be2ca2'
  })

  depends_on 'clutter_gtk' => :build
  depends_on 'desktop_file_utils' => :build
  depends_on 'gsound' => :build
  depends_on 'libgnome_games_support2' => :build
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
  depends_on 'libgnome_games_support2' # R
  depends_on 'pango' # R

  gnome
end
