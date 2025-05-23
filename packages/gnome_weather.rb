require 'buildsystems/meson'

class Gnome_weather < Meson
  description 'Access current weather conditions and forecasts'
  homepage 'https://wiki.gnome.org/Apps/Weather'
  version '48.0'
  license 'GPL-2+, LGPL-2+, MIT, CC-BY-3.0 and CC-BY-SA-3.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-weather.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '77e7e9f7ec1d0d065f84b1376dcd722d7e7913c3be8feff4da1dc90d41652182',
     armv7l: '77e7e9f7ec1d0d065f84b1376dcd722d7e7913c3be8feff4da1dc90d41652182',
     x86_64: 'e89af9c9a5522b3515cc9c06d41d90b010dc7629e416bb07b8823b44a97a05a7'
  })

  depends_on 'desktop_file_utilities' => :build
  depends_on 'gtk3' => :build
  depends_on 'gjs' => :build
  depends_on 'libgweather' => :build
  depends_on 'geoclue' => :build
  depends_on 'gnome_desktop' => :build
  depends_on 'gobject_introspection' => :build
  depends_on 'appstream_glib' => :build
  depends_on 'libhandy' => :build

  gnome
end
