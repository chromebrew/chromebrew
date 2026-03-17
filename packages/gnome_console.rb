# Adapted from Arch Linux gnome-console PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=gnome-console

require 'buildsystems/meson'

class Gnome_console < Meson
  description 'A simple user-friendly terminal emulator for the GNOME desktop'
  homepage 'https://gitlab.gnome.org/GNOME/console'
  version '50.0'
  license 'GPL3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/console.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e1e573875f2edd0b842a9290180e551bade62d4c9235f76985f5fcba867faf6f',
     armv7l: 'e1e573875f2edd0b842a9290180e551bade62d4c9235f76985f5fcba867faf6f',
     x86_64: '67d7580bfc3d67d2e12cd0491efe77cb3df3ad5fdff4717aad3af64b750b5c51'
  })

  depends_on 'desktop_file_utils' => :build
  depends_on 'gcc_lib' => :executable_only
  depends_on 'gdk_pixbuf' => :build
  depends_on 'glib' => :executable_only
  depends_on 'glibc' => :executable_only
  depends_on 'graphene' => :build
  depends_on 'gtk4' => :executable_only
  depends_on 'harfbuzz' => :build
  depends_on 'libadwaita' => :executable_only
  depends_on 'libgtop' => :executable_only
  depends_on 'libhandy' => :build
  depends_on 'nautilus' => :build
  depends_on 'pango' => :executable_only
  depends_on 'pcre2' => :build
  depends_on 'sassc' => :build
  depends_on 'vte' => :executable_only
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' # L

  gnome
end
