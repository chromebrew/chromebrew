require 'buildsystems/meson'

class Gnome_desktop < Meson
  description 'Library with common API for various GNOME modules'
  homepage 'https://gitlab.gnome.org/GNOME/gnome-desktop'
  version '51.0'
  license 'GPL-2+, LGPL-2+ and FDL-1.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-desktop.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5127f32fcbd23b4f4fb61de18b67cf6a688f58a72c2b7abe718f77b3e71eb77e',
     armv7l: '5127f32fcbd23b4f4fb61de18b67cf6a688f58a72c2b7abe718f77b3e71eb77e',
     x86_64: 'c4601efcb74a5f0be61f5933e944a2a77834aa810e63f060663e6dc1fee2649d'
  })

  depends_on 'cairo' => :library
  depends_on 'eudev' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'gdk_pixbuf' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gobject_introspection' => :build
  depends_on 'graphene' => :library
  depends_on 'gsettings_desktop_schemas' => :build
  depends_on 'gtk3' => :library
  depends_on 'gtk4' => :library
  depends_on 'gtk_doc' => :build
  depends_on 'harfbuzz' => :build
  depends_on 'iso_codes' => :build
  depends_on 'libjpeg_turbo' => :build
  depends_on 'libseccomp' => :library
  depends_on 'libxkbcommon' => :library
  depends_on 'libxkbfile' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' => :build
  depends_on 'xkeyboard_config' => :build
  depends_on 'yelp_tools' => :build

  gnome

  meson_options '-Dsystemd=disabled'
end
