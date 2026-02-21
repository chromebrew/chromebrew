require 'buildsystems/meson'

class Gnome_nibbles < Meson
  description 'snake game, up to four players'
  homepage 'https://wiki.gnome.org/Apps/Nibbles'
  version '4.5.0'
  license 'GPL-3+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-nibbles.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f2d5fc057f143933a26088617d646461f3bf7392f77879b4c03e822a0d8e73e6',
     armv7l: 'f2d5fc057f143933a26088617d646461f3bf7392f77879b4c03e822a0d8e73e6',
     x86_64: '257e330ffb2e07d50326fcf7ff6537b267b4852380cd89ec012505b8eaa0aa63'
  })

  depends_on 'cairo' # R
  depends_on 'clutter_gtk' => :build
  depends_on 'desktop_file_utils' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glib' => :executable_only
  depends_on 'glibc' => :executable_only
  depends_on 'gsound' => :executable_only
  depends_on 'gtk4' => :executable_only
  depends_on 'harfbuzz' # R
  depends_on 'libadwaita' => :executable_only
  depends_on 'libgee' => :executable_only
  depends_on 'libgnome_games_support' # R
  depends_on 'librsvg' => :build
  depends_on 'pango' => :executable_only
  depends_on 'py3_itstool' => :build
  depends_on 'vala' => :build
  depends_on 'wayland' => :build

  gnome
end
