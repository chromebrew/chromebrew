require 'buildsystems/meson'

class Gnome_nibbles < Meson
  description 'snake game, up to four players'
  homepage 'https://wiki.gnome.org/Apps/Nibbles'
  version '4.5.1'
  license 'GPL-3+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-nibbles.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7854676bf4fc83e2e08a66592d1470a3cc634f7e583792f93ffe0d6731eda391',
     armv7l: '7854676bf4fc83e2e08a66592d1470a3cc634f7e583792f93ffe0d6731eda391',
     x86_64: '323fcf07c08a8c78a54d19f16bf7da536629814f947259056ea4698ff319a081'
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
