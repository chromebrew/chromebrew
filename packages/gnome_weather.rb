require 'package'

class Gnome_weather < Package
  description 'Access current weather conditions and forecasts'
  homepage 'https://wiki.gnome.org/Apps/Weather'
  version '40.0'
  license 'GPL-2+, LGPL-2+, MIT, CC-BY-3.0 and CC-BY-SA-3.0'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/gnome-weather/-/archive/#{version}/gnome-weather-#{version}.tar.bz2"
  source_sha256 'f687caa96f357ec6bf7a4c3c376e82f7476d0b711b9e670a2f074a069c7531d8'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_weather/40.0_armv7l/gnome_weather-40.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_weather/40.0_armv7l/gnome_weather-40.0-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_weather/40.0_i686/gnome_weather-40.0-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_weather/40.0_x86_64/gnome_weather-40.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'f90c5fb9bb00e103e66017515f5b0206dc1baeb2650e329c16f4a20bde827ab5',
     armv7l: 'f90c5fb9bb00e103e66017515f5b0206dc1baeb2650e329c16f4a20bde827ab5',
       i686: 'ebd913d1c610d9124dcd16be06a4171807cbae7038cf300d1825ef7c0931be95',
     x86_64: '6c388c10b42fdf5e9e59cdf373b9aa0340bd991107886543c873f7d6a8b281d9'
  })

  depends_on 'gtk3'
  depends_on 'gjs'
  depends_on 'libgweather'
  depends_on 'geoclue'
  depends_on 'gnome_desktop'
  depends_on 'gobject_introspection' => :build
  depends_on 'appstream_glib' => :build
  depends_on 'libhandy'

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    -Dsystemd=disabled \
    builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
