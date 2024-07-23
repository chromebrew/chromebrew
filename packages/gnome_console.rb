# Adapted from Arch Linux gnome-console PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=gnome-console

require 'buildsystems/meson'

class Gnome_console < Meson
  description 'A simple user-friendly terminal emulator for the GNOME desktop'
  homepage 'https://gitlab.gnome.org/GNOME/console'
  version '46.rc'
  license 'GPL3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/console.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0e18752cb72dff86cba422d967e1d12dcc5a09b5edaa65f26bc79ee657abe75b',
     armv7l: '0e18752cb72dff86cba422d967e1d12dcc5a09b5edaa65f26bc79ee657abe75b',
     x86_64: '837c952b979c300f72e1a1ea00c6e7c57f50e2d96dcc028a4f89b5f3e2a012cf'
  })

  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' => :build
  depends_on 'glibc' # R
  depends_on 'glib' # R
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
