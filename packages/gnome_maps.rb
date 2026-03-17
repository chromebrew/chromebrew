require 'buildsystems/meson'

class Gnome_maps < Meson
  description 'A simple GNOME maps application'
  homepage 'https://wiki.gnome.org/Apps/Maps'
  version '50.0'
  license 'GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-maps.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '82413b6437978261ecd77b28ccdec8ed8bd74058bc24a9c1cdd39b15c8414ed6',
     armv7l: '82413b6437978261ecd77b28ccdec8ed8bd74058bc24a9c1cdd39b15c8414ed6',
     x86_64: '384832259621ef18a2cddc6328169f7d606b153dd93558cccef2406c9a15835d'
  })

  depends_on 'blueprint_compiler'
  depends_on 'cairo' # R
  depends_on 'desktop_file_utils' => :build
  depends_on 'folks' => :build
  depends_on 'geoclue' # R
  depends_on 'geocode_glib2' # R
  depends_on 'gjs' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gnome_weather' => :build
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk4' # R
  depends_on 'harfbuzz' # R
  depends_on 'json_glib' # R
  depends_on 'libadwaita' # R
  depends_on 'libchamplain' => :build
  depends_on 'libgee' => :build
  depends_on 'libgweather' # R
  depends_on 'libhandy' => :build
  depends_on 'libportal' # R
  depends_on 'librsvg' # R
  depends_on 'libsecret' # R
  depends_on 'libshumate' # R
  depends_on 'libxml2' # R
  depends_on 'pango' # R
  depends_on 'rest' # R
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader'
  depends_on 'yelp_tools' => :build

  gnome
end
