require 'buildsystems/meson'

class Libgweather < Meson
  description 'Location and timezone database and weather-lookup library'
  homepage 'https://wiki.gnome.org/Projects/LibGWeather'
  version '4.4.4'
  license 'GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/libgweather.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8a71fa4bd2f9d5db80f6c8b5b6ab70cc113b6cc670fbce379f5d6fddd030bafc',
     armv7l: '8a71fa4bd2f9d5db80f6c8b5b6ab70cc113b6cc670fbce379f5d6fddd030bafc',
     x86_64: '22e246542730d6b073e93c6e86c3313bb4219ed123ea6f855f4a7579c3494550'
  })

  depends_on 'dconf' => :build
  depends_on 'geocode_glib2' # R
  depends_on 'glade' => :build
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk3' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'json_glib' # R
  depends_on 'libsoup' # R
  depends_on 'libxml2' # R
  depends_on 'py3_gi_docgen' => :build
  depends_on 'py3_pygobject' => :build
  depends_on 'py3_pylint' => :build
  depends_on 'py3_smartypants' => :build

  gnome

  meson_options "-Dzoneinfo_dir=#{CREW_PREFIX}/share/zoneinfo -Dgtk_doc=false -Dsoup2=false -Dtests=false"
end
