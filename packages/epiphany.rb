# Adapted from Arch Linux epiphany PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/epiphany/trunk/PKGBUILD

require 'buildsystems/meson'

class Epiphany < Meson
  description 'A GNOME web browser based on the WebKit rendering engine'
  homepage 'https://wiki.gnome.org/Apps/Web'
  version '50.3'
  license 'GPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/epiphany.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '401276c879daeea2e680e2255f2ad4cdcc96653881a5127945170a723a0f6986',
     armv7l: '401276c879daeea2e680e2255f2ad4cdcc96653881a5127945170a723a0f6986',
     x86_64: '16ca64b584e1313a6388ce01abccbee66c6719ae557329cb818e306698c0ee07'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'blueprint_compiler' => :build
  depends_on 'cairo' # R
  depends_on 'desktop_file_utils' # R
  depends_on 'docbook_xml' => :build
  depends_on 'freetype' => :build
  depends_on 'gcc_lib' # R
  depends_on 'gcr_4' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gstreamer' # R
  depends_on 'gtk3' # R
  depends_on 'gtk4' # R
  depends_on 'harfbuzz' # R
  depends_on 'help2man' => :build
  depends_on 'iso_codes' => :build
  depends_on 'json_glib' # R
  depends_on 'libadwaita' # R
  depends_on 'libarchive' # R
  depends_on 'libdazzle' # R
  depends_on 'libhandy' # R
  depends_on 'libportal' # R
  depends_on 'libsecret' # R
  depends_on 'libsoup' # R
  depends_on 'libxml2' # R
  depends_on 'lsb_release' => :build
  depends_on 'nettle' # R
  depends_on 'pango' # R
  depends_on 'py3_docutils' => :build
  depends_on 'py3_itstool' # R
  depends_on 'py3_pygobject' => :build
  depends_on 'sqlite' # R
  depends_on 'startup_notification' => :build
  depends_on 'valgrind' => :build
  depends_on 'webkitgtk_6' # R

  gnome
end
