# Adapted from Arch Linux gnome-console PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=gnome-console

require 'buildsystems/meson'

class Gnome_console < Meson
  description 'A simple user-friendly terminal emulator for the GNOME desktop'
  homepage 'https://gitlab.gnome.org/GNOME/console'
  version '49.2'
  license 'GPL3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/console.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '36bea987e21d954b5dddaae7a1a84cba56fd082e1058d3fdc7ab5fe69a14df94',
     armv7l: '36bea987e21d954b5dddaae7a1a84cba56fd082e1058d3fdc7ab5fe69a14df94',
     x86_64: '35746d34093f1d5b2e109fdee4ba49f6dbec112c8716e6929f4e390add0170af'
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
