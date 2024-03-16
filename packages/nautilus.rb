# Adapted from Arch Linux nautilus PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/nautilus/trunk/PKGBUILD

require 'buildsystems/meson'

class Nautilus < Meson
  description 'Default file manager for GNOME'
  homepage 'https://wiki.gnome.org/Apps/Files'
  version '46.rc'
  license 'GPLv3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/nautilus.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7aa9ac926a916451288e17fa7eff600afb79530c9eade1bbf7724049ad5a9059',
     armv7l: '7aa9ac926a916451288e17fa7eff600afb79530c9eade1bbf7724049ad5a9059',
     x86_64: '8bad0c1b95bd31109c9df5811aeeda5a15d18e2b2756523136b9e072fca53af0'
  })

  depends_on 'appstream_glib' => :build
  depends_on 'at_spi2_core' => :build
  depends_on 'cairo' => :build
  depends_on 'dconf' => :build
  depends_on 'desktop_file_utils' => :build
  depends_on 'gcc_lib' => :build
  depends_on 'gdk_pixbuf' => :build
  depends_on 'gexiv2' => :build
  depends_on 'glibc' => :build
  depends_on 'glib' => :build
  depends_on 'gnome_autoar' => :build
  depends_on 'gnome_desktop' => :build
  depends_on 'gobject_introspection' => :build
  depends_on 'graphene' => :build
  depends_on 'gstreamer' => :build
  depends_on 'gtk3' => :build
  depends_on 'gtk4' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'gvfs' => :build
  depends_on 'harfbuzz' => :build
  depends_on 'iso_codes' => :build
  depends_on 'libadwaita' => :build
  depends_on 'libarchive' => :build
  depends_on 'libcloudproviders' => :build
  depends_on 'libhandy' => :build
  depends_on 'libjpeg' => :build
  depends_on 'libportal' => :build
  depends_on 'libxml2' => :build
  depends_on 'pango' => :build
  depends_on 'tracker3_miners' => :build
  depends_on 'tracker3' => :build
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
