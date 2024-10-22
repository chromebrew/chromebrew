require 'buildsystems/meson'

class Gnome_weather < Meson
  description 'Access current weather conditions and forecasts'
  homepage 'https://wiki.gnome.org/Apps/Weather'
  version '45.0'
  license 'GPL-2+, LGPL-2+, MIT, CC-BY-3.0 and CC-BY-SA-3.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-weather.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '666624e236a5bdeb5cf5babd00e521a8e647158bf97d3d83e5ccae37e40bf23c',
     armv7l: '666624e236a5bdeb5cf5babd00e521a8e647158bf97d3d83e5ccae37e40bf23c',
     x86_64: '5a4811dfc9fcdfc77908302ddab627d153873780296f3d51e534f739198c74c0'
  })

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
