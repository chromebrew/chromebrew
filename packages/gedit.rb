require 'buildsystems/meson'

class Gedit < Meson
  description 'GNOME Text Editor'
  homepage 'https://wiki.gnome.org/Apps/Gedit'
  version '46.2'
  license 'GPL-2+ CC-BY-SA-3.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/gedit.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd00004e8fe0b7f2f9c1884f4f7657b208ac504cf9b19ef033f58559b4683588f',
     armv7l: 'd00004e8fe0b7f2f9c1884f4f7657b208ac504cf9b19ef033f58559b4683588f',
     x86_64: 'dc1aee9657dfa305d79fd9f4c582515886aeb6254d06794271997385d5f3060d'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'gedit_amtk' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' # R
  depends_on 'gsettings_desktop_schemas' # L
  depends_on 'gspell' # R
  depends_on 'gtk3' # R
  depends_on 'gtk_doc' => :build
  depends_on 'gtksourceview_4' # R
  depends_on 'libpeas' # R
  depends_on 'pango' # R
  depends_on 'pygobject' => :build
  depends_on 'tepl_6' # R
  depends_on 'vala' => :build
  depends_on 'yelp_tools' => :build

  meson_options '-Drequire_all_tests=false \
    -Duser_documentation=false'
end
