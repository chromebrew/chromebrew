require 'buildsystems/meson'

class Gnome_maps < Meson
  description 'A simple GNOME maps application'
  homepage 'https://wiki.gnome.org/Apps/Maps'
  version '46.rc'
  license 'GPL-2+, LGPL-2+, MIT, CC-BY-3.0 and CC-BY-SA-3.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-maps.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd46b5f25779c2f3d261e77bbd6d26d4d8ab3c69879821b95ec7f2d637fa32147',
     armv7l: 'd46b5f25779c2f3d261e77bbd6d26d4d8ab3c69879821b95ec7f2d637fa32147',
     x86_64: '204839763a97c30d6c14be1dfad9ea578f9df6e2c6534e14f0b95c7f5bd93fed'
  })

  depends_on 'cairo' # R
  depends_on 'folks' => :build
  depends_on 'geoclue' => :build
  depends_on 'geocode_glib2' => :build
  depends_on 'geocode_glib' => :build
  depends_on 'gfbgraph' => :build
  depends_on 'gjs' => :build
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk4' # R
  depends_on 'harfbuzz' # R
  depends_on 'json_glib' # R
  depends_on 'libchamplain' => :build
  depends_on 'libgee' => :build
  depends_on 'libhandy' => :build
  depends_on 'librsvg' # R
  depends_on 'libshumate' # R
  depends_on 'libxml2' # R
  depends_on 'pango' # R
  depends_on 'rest' # R
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader'
  depends_on 'yelp_tools' => :build

  gnome

  def self.patch
    system "sed -i 's/geocode-glib-2.0/geocode-glib-1.0/g' meson.build"
  end
end
