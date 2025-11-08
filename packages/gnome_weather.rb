require 'buildsystems/meson'

class Gnome_weather < Meson
  description 'Access current weather conditions and forecasts'
  homepage 'https://wiki.gnome.org/Apps/Weather'
  version '49.0'
  license 'GPL-2+, LGPL-2+, MIT, CC-BY-3.0 and CC-BY-SA-3.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-weather.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '27ef669e2907301a76381ae49b74337db9772c15a2b657b5c927bd984b38babc',
     armv7l: '27ef669e2907301a76381ae49b74337db9772c15a2b657b5c927bd984b38babc',
     x86_64: '53c381245c2635feb202d9aa05ddc4f9d44febe0b0006b0150d70df2ec4c2fa7'
  })

  depends_on 'desktop_file_utilities' => :build
  depends_on 'gtk3' => :build
  depends_on 'gjs' => :build
  depends_on 'libadwaita' => :build
  depends_on 'libgweather' => :build
  depends_on 'geoclue' => :build
  depends_on 'gnome_desktop' => :build
  depends_on 'gobject_introspection' => :build
  depends_on 'appstream_glib' => :build
  depends_on 'libhandy' => :build
  depends_on 'typescript' => :build

  gnome
end
