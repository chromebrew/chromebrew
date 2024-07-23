require 'buildsystems/meson'

class Libgweather < Meson
  description 'Location and timezone database and weather-lookup library'
  homepage 'https://wiki.gnome.org/Projects/LibGWeather'
  version '4.4.0'
  license 'GPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/libgweather.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '636d43908dcb6601e60c336942230cd51962f104e147f87c9d5c6ee8dd770286',
     armv7l: '636d43908dcb6601e60c336942230cd51962f104e147f87c9d5c6ee8dd770286',
     x86_64: 'f5262a74f6830ca6cd311241d6e1ff6986c2d818326c78efd9e3f0934d2c9c87'
  })

  depends_on 'dconf' => :build
  depends_on 'geocode_glib' # R
  depends_on 'glade' => :build
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk3' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'json_glib' # R
  depends_on 'libsoup2' # R
  depends_on 'libxml2' # R
  depends_on 'py3_gi_docgen' => :build
  depends_on 'py3_pylint' => :build
  depends_on 'py3_smartypants' => :build
  depends_on 'pygobject' => :build

  gnome

  meson_options '-Dsoup2=true'
end
