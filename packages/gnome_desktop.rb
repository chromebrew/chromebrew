require 'buildsystems/meson'

class Gnome_desktop < Meson
  description 'Library with common API for various GNOME modules'
  homepage 'https://gitlab.gnome.org/GNOME/gnome-desktop'
  version '44.0'
  license 'GPL-2+, LGPL-2+ and FDL-1.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-desktop.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8a75b2934ddd3d994786dde1a04353d82818e88699e0346d66cd04ed74ae203b',
     armv7l: '8a75b2934ddd3d994786dde1a04353d82818e88699e0346d66cd04ed74ae203b',
     x86_64: '22f94e150bfd04670f4908293e80b9e2f41f228bdbf538be17276384b817c350'
  })

  depends_on 'cairo' # R
  depends_on 'eudev' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gsettings_desktop_schemas' => :build
  depends_on 'gtk3' # R
  depends_on 'gtk4' # R
  depends_on 'gtk_doc' => :build
  depends_on 'harfbuzz' # R
  depends_on 'iso_codes' => :build
  depends_on 'libjpeg' => :build
  depends_on 'libseccomp' # R
  depends_on 'libxkbcommon' # R
  depends_on 'libxkbfile' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' => :build
  depends_on 'xkeyboard_config' => :build
  depends_on 'yelp_tools' => :build

  gnome

  meson_options '-Dsystemd=disabled'
end
