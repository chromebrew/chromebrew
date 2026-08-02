require 'buildsystems/meson'

class Gnome_maps < Meson
  description 'A simple GNOME maps application'
  homepage 'https://wiki.gnome.org/Apps/Maps'
  version '50.3'
  license 'GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-maps.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '010b426aa499e45277f4cbee04d25bc5dca3f3263f12e9ddac0a2fe130dce86c',
     armv7l: '010b426aa499e45277f4cbee04d25bc5dca3f3263f12e9ddac0a2fe130dce86c',
     x86_64: '4ef6b74a8cec85d6dc32c4e84562da414d567f3b90b7b7e18075a8ae96706b76'
  })

  depends_on 'blueprint_compiler'
  depends_on 'cairo' => :library
  depends_on 'desktop_file_utils' => :build
  depends_on 'folks' => :build
  depends_on 'geoclue' # R
  depends_on 'geocode_glib2' # R
  depends_on 'gjs' # R
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gnome_weather' => :build
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk4' => :library
  depends_on 'harfbuzz' # R
  depends_on 'json_glib' => :library
  depends_on 'libadwaita' # R
  depends_on 'libchamplain' => :build
  depends_on 'libgee' => :build
  depends_on 'libgweather' # R
  depends_on 'libhandy' => :build
  depends_on 'libportal' # R
  depends_on 'librsvg' => :library
  depends_on 'libsecret' # R
  depends_on 'libshumate' => :library
  depends_on 'libxml2' => :library
  depends_on 'pango' => :library
  depends_on 'rest' # R
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader'
  depends_on 'yelp_tools' => :build

  gnome
end
