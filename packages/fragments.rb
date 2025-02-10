require 'buildsystems/meson'

class Fragments < Meson
  description 'Fragments is an easy to use BitTorrent client for the GNOME desktop environment.'
  homepage 'https://gitlab.gnome.org/World/Fragments'
  version '3.0.1'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/World/Fragments.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '25d0efa28dd021a0e720f619504ba2e27dedc05bdc3da2b4210dc8cb5c4d97ed',
     armv7l: '25d0efa28dd021a0e720f619504ba2e27dedc05bdc3da2b4210dc8cb5c4d97ed',
     x86_64: '7cb18718258f6b20b31f65e61f072609e13bc79c7fe6b7efd7722222d2ae34fd'
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
  depends_on 'zlib' # R

  gnome
end
