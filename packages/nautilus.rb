# Adapted from Arch Linux nautilus PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/nautilus/trunk/PKGBUILD

require 'buildsystems/meson'

class Nautilus < Meson
  description 'Default file manager for GNOME'
  homepage 'https://wiki.gnome.org/Apps/Files'
  version '48.0'
  license 'GPLv3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/nautilus.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a273e282589015b336b968e3945b931898021aa4818595bcef78efc08b0c1424',
     armv7l: 'a273e282589015b336b968e3945b931898021aa4818595bcef78efc08b0c1424',
     x86_64: 'bfd42a2ec2f237eb10cfa8e000ff8ebdf7b00e6ffcf8c77f50adfd04e3d280ce'
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
  depends_on 'libx11' # R
  depends_on 'libxml2' => :build
  depends_on 'localsearch' => :build
  depends_on 'pango' # R
  depends_on 'tinysparql' # R
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' => :build
  depends_on 'wayland' # R

  gnome

  meson_options '-Ddocs=false \
    -Dpackagekit=false \
    -Dtests=headless'

  def self.postinstall
    FileUtils.touch "#{HOME}/.gtk-bookmarks"
  end
end
