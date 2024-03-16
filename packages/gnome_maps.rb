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
     x86_64: 'f2f638b2c045495f20509ef548617f273f79116a5fd0705e7842e33f4e9ad06c'
  })

  depends_on 'geocode_glib' => :build
  depends_on 'geocode_glib2' => :build
  depends_on 'geoclue' => :build
  depends_on 'gjs' => :build
  depends_on 'gtk3' => :build
  depends_on 'gtk4' => :build
  depends_on 'libchamplain' => :build
  depends_on 'libgee' => :build
  depends_on 'libhandy' => :build
  depends_on 'libshumate' => :build
  depends_on 'folks' => :build
  depends_on 'gfbgraph' => :build
  depends_on 'gobject_introspection' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader'
  depends_on 'yelp_tools' => :build
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'libxml2' # R
  depends_on 'rest' # R

  gnome

  def self.patch
    system "sed -i 's/geocode-glib-2.0/geocode-glib-1.0/g' meson.build"
  end
end
