require 'buildsystems/meson'

class Libgweather < Meson
  description 'Location and timezone database and weather-lookup library'
  homepage 'https://wiki.gnome.org/Projects/LibGWeather'
  version '4.4.0'
  license 'GPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/libgweather.git'
  git_hashtag 
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '40a0fe50c8ec6ac566a278531b27633a226d7aab695b91fb90b97a039775be47',
     armv7l: '40a0fe50c8ec6ac566a278531b27633a226d7aab695b91fb90b97a039775be47',
     x86_64: '3977878b91e477fcb590870b8595daf53e6a032bcf8a793da5bf6d1285b3ffe7'
  })

  depends_on 'libsoup' => :build
  depends_on 'gtk3' => :build
  depends_on 'dconf' => :build
  depends_on 'geocode_glib' => :build
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'glade' => :build
  depends_on 'glib' => :build
  depends_on 'glibc' => :build
  depends_on 'libsoup2' => :build
  depends_on 'libxml2' => :build
  depends_on 'py3_gi_docgen' => :build
  depends_on 'py3_smartypants' => :build
  depends_on 'json_glib' => :build

  gnome

  meson_options '-Dsoup2=true'
end
