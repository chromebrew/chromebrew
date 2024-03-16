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
    aarch64: 'd608f85f6be5ac19407ef71df3f6e398bb6fd0a412a935063b8464cb7fcf6a55',
     armv7l: 'd608f85f6be5ac19407ef71df3f6e398bb6fd0a412a935063b8464cb7fcf6a55',
     x86_64: '5867de4e7b37bd255dcc087700866c36b465249549a718666c6cd834cbf7fe2a'
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
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gnome_autoar' # R
  depends_on 'gnome_desktop' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'graphene' => :build
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
  depends_on 'libjpeg' => :build
  depends_on 'libportal' # R
  depends_on 'libxml2' => :build
  depends_on 'pango' => :build
  depends_on 'pango' # R
  depends_on 'tracker3_miners' => :build
  depends_on 'tracker3' # R
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
