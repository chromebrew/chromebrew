# Adapted from Arch Linux nautilus PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/nautilus/trunk/PKGBUILD

require 'buildsystems/meson'

class Nautilus < Meson
  description 'Default file manager for GNOME'
  homepage 'https://wiki.gnome.org/Apps/Files'
  version '46.2'
  license 'GPLv3'
  compatibility 'x86_64 aarch64 armv7l'
  min_glibc '2.37'
  source_url 'https://gitlab.gnome.org/GNOME/nautilus.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a9108646b99aa5f1ed6a82fc6c841791eddddfaabebae08064e7dbcfb2d28ef7',
     armv7l: 'a9108646b99aa5f1ed6a82fc6c841791eddddfaabebae08064e7dbcfb2d28ef7',
     x86_64: '760d0a5029e887e93f849db2440b5b149dd7499e21b213b9ddc95ba7b997bfe5'
  })

  depends_on 'appstream' => :build
  depends_on 'appstream_glib' => :build
  depends_on 'at_spi2_core' => :build
  depends_on 'cairo' # R
  depends_on 'dconf' => :build
  depends_on 'desktop_file_utils' => :build
  depends_on 'gcc_lib' => :build
  depends_on 'gdk_pixbuf' # R
  depends_on 'gexiv2' # R
  depends_on 'glibc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gnome_autoar' # R
  depends_on 'gnome_desktop' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'graphene' # R
  depends_on 'gstreamer' # R
  depends_on 'gtk3' => :build
  depends_on 'gtk4' # R
  depends_on 'gtk_doc' => :build
  depends_on 'gvfs' => :build
  depends_on 'harfbuzz' # R
  depends_on 'iso_codes' => :build
  depends_on 'libadwaita' # R
  depends_on 'libarchive' => :build
  depends_on 'libcloudproviders' # R
  depends_on 'libhandy' => :build
  depends_on 'libjpeg_turbo' => :build
  depends_on 'libportal' # R
  depends_on 'libxml2' => :build
  depends_on 'localsearch' => :build
  depends_on 'pango' # R
  depends_on 'tinysparql' # R
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' => :build

  gnome

  meson_options '-Ddocs=false \
    -Dpackagekit=false \
    -Dtests=headless'

  def self.postinstall
    FileUtils.touch "#{HOME}/.gtk-bookmarks"
  end
end
