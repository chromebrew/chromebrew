require 'buildsystems/meson'

class Gnome_maps < Meson
  description 'A simple GNOME maps application'
  homepage 'https://wiki.gnome.org/Apps/Maps'
  version '49.4'
  license 'GPL-2+, LGPL-2+, MIT, CC-BY-3.0 and CC-BY-SA-3.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-maps.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '757812f0671443c6fb4eba9aa727d5db6c8a54d5614771f644c82582877c1c04',
     armv7l: '757812f0671443c6fb4eba9aa727d5db6c8a54d5614771f644c82582877c1c04',
     x86_64: '5aca499e006b3831ec8acf82ed669de79f65f982ffd7fbff9ddc2c35370dbd9f'
  })

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
