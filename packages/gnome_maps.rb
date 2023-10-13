require 'package'

class Gnome_maps < Package
  description 'A simple GNOME maps application'
  homepage 'https://wiki.gnome.org/Apps/Maps'
  version '43.0'
  license 'GPL-2+, LGPL-2+, MIT, CC-BY-3.0 and CC-BY-SA-3.0'
  compatibility 'armv7l aarch64 x86_64'
  source_url "https://gitlab.gnome.org/GNOME/gnome-maps/-/archive/v#{version}/gnome-maps-v#{version}.tar.bz2"
  source_sha256 '5e580c23a86f6b63d7c923aac7e6351e7b6765c74298f6a811d5a398a378db12'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_maps/43.0_armv7l/gnome_maps-43.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_maps/43.0_armv7l/gnome_maps-43.0-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_maps/43.0_x86_64/gnome_maps-43.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f3f61311c9873f36bb12a0d64fef535cf92dc7ef15e88e209890e0f5d6ed2514',
     armv7l: 'f3f61311c9873f36bb12a0d64fef535cf92dc7ef15e88e209890e0f5d6ed2514',
     x86_64: 'f2f638b2c045495f20509ef548617f273f79116a5fd0705e7842e33f4e9ad06c'
  })

  depends_on 'geocode_glib'
  depends_on 'geocode_glib2'
  depends_on 'geoclue'
  depends_on 'gjs'
  depends_on 'gtk3'
  depends_on 'gtk4'
  depends_on 'libchamplain'
  depends_on 'libgee'
  depends_on 'libhandy'
  depends_on 'libshumate'
  depends_on 'folks'
  depends_on 'gfbgraph'
  depends_on 'gobject_introspection' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader'
  depends_on 'yelp_tools' => :build
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'libxml2' # R
  depends_on 'rest' # R

  def self.patch
    system "sed -i 's/geocode-glib-2.0/geocode-glib-1.0/g' meson.build"
  end

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
