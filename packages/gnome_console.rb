# Adapted from Arch Linux gnome-console PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=gnome-console

require 'buildsystems/meson'

class Gnome_console < Meson
  description 'A simple user-friendly terminal emulator for the GNOME desktop'
  homepage 'https://gitlab.gnome.org/GNOME/console'
  version '49.1'
  license 'GPL3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/console.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd98688fc6f040398610854a59bea601c590e159070b692a90d9afbbec2101baa',
     armv7l: 'd98688fc6f040398610854a59bea601c590e159070b692a90d9afbbec2101baa',
     x86_64: '3439833b9952b4af914ce8eb4f35d15623da5d7426bace7896d44357faaa5852'
  })

  depends_on 'desktop_file_utils' => :build
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' => :build
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'graphene' => :build
  depends_on 'gtk4' # R
  depends_on 'harfbuzz' => :build
  depends_on 'libadwaita' # R
  depends_on 'libgtop' # R
  depends_on 'libhandy' => :build
  depends_on 'nautilus' => :build
  depends_on 'pango' # R
  depends_on 'pcre2' => :build
  depends_on 'sassc' => :build
  depends_on 'vte' # R
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' # L

  gnome
end
