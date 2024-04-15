require 'buildsystems/meson'

class Fragments < Meson
  description 'Fragments is an easy to use BitTorrent client for the GNOME desktop environment.'
  homepage 'https://gitlab.gnome.org/World/Fragments'
  version '2.1.1'
  license 'GPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/World/Fragments.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '33e98a3b0d123ceca18cd75b6dbff51d2954d68e4dbc22f58bb029db2ad47d8b',
     armv7l: '33e98a3b0d123ceca18cd75b6dbff51d2954d68e4dbc22f58bb029db2ad47d8b',
     x86_64: 'c6f41d839e093bb7a70c23d2cce442814aed0d31b5468b7032b00b2fc93bb39e'
  })

  depends_on 'appstream' => :build
  depends_on 'cairo' # R
  depends_on 'dbus' => :build
  depends_on 'desktop_file_utils' => :build
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'graphene' => :build
  depends_on 'gtk4' # R
  depends_on 'harfbuzz' # R
  depends_on 'libadwaita' # R
  depends_on 'openssl' # R
  depends_on 'pango' # R
  depends_on 'rust' => :build
  depends_on 'transmission' # L
  depends_on 'zlibpkg' # R

  gnome
end
