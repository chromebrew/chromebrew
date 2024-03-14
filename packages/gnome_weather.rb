require 'buildsystems/meson'

class Gnome_weather < Meson
  description 'Access current weather conditions and forecasts'
  homepage 'https://wiki.gnome.org/Apps/Weather'
  version '40.0'
  license 'GPL-2+, LGPL-2+, MIT, CC-BY-3.0 and CC-BY-SA-3.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://gitlab.gnome.org/GNOME/gnome-weather/-/archive/#{version}/gnome-weather-#{version}.tar.bz2"
  source_sha256 'f687caa96f357ec6bf7a4c3c376e82f7476d0b711b9e670a2f074a069c7531d8'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'f90c5fb9bb00e103e66017515f5b0206dc1baeb2650e329c16f4a20bde827ab5',
     armv7l: 'f90c5fb9bb00e103e66017515f5b0206dc1baeb2650e329c16f4a20bde827ab5',
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

  gnome

  meson_options '-Dsystemd=disabled'
end
