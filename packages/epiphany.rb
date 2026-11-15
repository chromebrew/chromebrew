# Adapted from Arch Linux epiphany PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/epiphany/trunk/PKGBUILD

require 'buildsystems/meson'

class Epiphany < Meson
  description 'A GNOME web browser based on the WebKit rendering engine'
  homepage 'https://wiki.gnome.org/Apps/Web'
  version '50.6'
  license 'GPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/epiphany.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '54721263eb419610ec8c1c965b4e91e432a50464f6d9b92ebae9b2d5c55505ad',
     armv7l: '54721263eb419610ec8c1c965b4e91e432a50464f6d9b92ebae9b2d5c55505ad',
     x86_64: '15dfab28b9cca1f8d07757cd9a23896fd77ce15267909beb405879b0c0ee6f4f'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'blueprint_compiler' => :build
  depends_on 'cairo' => :library
  depends_on 'desktop_file_utils' # R
  depends_on 'docbook_xml' => :build
  depends_on 'freetype' => :build
  depends_on 'gcc_lib' # R
  depends_on 'gcr_4' => :library
  depends_on 'gdk_pixbuf' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gmp' => :library
  depends_on 'gobject_introspection' => :build
  depends_on 'gstreamer' => :library
  depends_on 'gtk3' # R
  depends_on 'gtk4' => :library
  depends_on 'harfbuzz' # R
  depends_on 'help2man' => :build
  depends_on 'iso_codes' => :build
  depends_on 'json_glib' => :library
  depends_on 'libadwaita' => :library
  depends_on 'libarchive' => :library
  depends_on 'libdazzle' # R
  depends_on 'libhandy' # R
  depends_on 'libportal' => :library
  depends_on 'libsecret' => :library
  depends_on 'libsoup' => :library
  depends_on 'libxml2' => :library
  depends_on 'lsb_release' => :build
  depends_on 'nettle' => :library
  depends_on 'pango' => :library
  depends_on 'py3_docutils' => :build
  depends_on 'py3_itstool' # R
  depends_on 'py3_pygobject' => :build
  depends_on 'sqlite' # R
  depends_on 'startup_notification' => :build
  depends_on 'valgrind' => :build
  depends_on 'webkitgtk_6' => :library

  gnome
end
