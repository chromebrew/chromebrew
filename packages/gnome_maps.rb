require 'buildsystems/meson'

class Gnome_maps < Meson
  description 'A simple GNOME maps application'
  homepage 'https://wiki.gnome.org/Apps/Maps'
  version '49.2'
  license 'GPL-2+, LGPL-2+, MIT, CC-BY-3.0 and CC-BY-SA-3.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-maps.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aa8e60521f23ca1a3263114605fcf6dcc381caf6eaf086a223a03781cef64251',
     armv7l: 'aa8e60521f23ca1a3263114605fcf6dcc381caf6eaf086a223a03781cef64251',
     x86_64: 'c05459c1373316f079482fbb475ee9a1587dca8456ff897805aedd5ea0dc443c'
  })

  depends_on 'cairo' # R
  depends_on 'desktop_file_utils' => :build
  depends_on 'folks' => :build
  depends_on 'geoclue' => :build
  depends_on 'geocode_glib2' => :build
  depends_on 'gjs' => :build
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gnome_weather' => :build
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk4' # R
  depends_on 'harfbuzz' # R
  depends_on 'json_glib' # R
  depends_on 'libadwaita' => :build
  depends_on 'libchamplain' => :build
  depends_on 'libgee' => :build
  depends_on 'libgweather' => :build
  depends_on 'libhandy' => :build
  depends_on 'libportal' => :build
  depends_on 'librsvg' # R
  depends_on 'libshumate' # R
  depends_on 'libxml2' # R
  depends_on 'pango' # R
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader'
  depends_on 'yelp_tools' => :build

  gnome
end
