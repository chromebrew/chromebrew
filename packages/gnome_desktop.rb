require 'buildsystems/meson'

class Gnome_desktop < Meson
  description 'Library with common API for various GNOME modules'
  homepage 'https://gitlab.gnome.org/GNOME/gnome-desktop'
  version '44.5'
  license 'GPL-2+, LGPL-2+ and FDL-1.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-desktop.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cf52cfdd6da99e26f5317a6587b53f2847b210d2102e2787beee7f249d968035',
     armv7l: 'cf52cfdd6da99e26f5317a6587b53f2847b210d2102e2787beee7f249d968035',
     x86_64: 'bd7a97f8025604eee297aaf858727041fbe7a660cda059d5d70077615404a0a5'
  })

  depends_on 'cairo' # R
  depends_on 'eudev' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gsettings_desktop_schemas' => :build
  depends_on 'gtk3' # R
  depends_on 'gtk4' # R
  depends_on 'gtk_doc' => :build
  depends_on 'harfbuzz' # R
  depends_on 'iso_codes' => :build
  depends_on 'libjpeg_turbo' => :build
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
