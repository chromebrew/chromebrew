require 'buildsystems/meson'

class Gnome_weather < Meson
  description 'Access current weather conditions and forecasts'
  homepage 'https://wiki.gnome.org/Apps/Weather'
  version '50.0'
  license 'GPL-2+, LGPL-2+, MIT, CC-BY-3.0 and CC-BY-SA-3.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-weather.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0d35568c64296cfcd9ea1df5b2e3e07e8207371205a2ee32d8ee56e8187c8bf4',
     armv7l: '0d35568c64296cfcd9ea1df5b2e3e07e8207371205a2ee32d8ee56e8187c8bf4',
     x86_64: '2f233836e7205392aabff2c4d42a67727a6add480b83950995f2201637ab2e35'
  })

  depends_on 'desktop_file_utilities' => :executable
  depends_on 'geoclue' => :library
  depends_on 'gjs' => :library
  depends_on 'gnome_desktop' => :executable
  depends_on 'gobject_introspection' => :library
  depends_on 'gtk3' => :executable
  depends_on 'appstream_glib' => :library
  depends_on 'libadwaita' => :library
  depends_on 'libgweather' => :library
  depends_on 'libhandy' => :library
  depends_on 'typescript' => :library

  gnome
end
