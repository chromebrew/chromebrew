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
    aarch64: '835806e05b5fb7054ca5bb06119aa013d556fe2d908bbb64ffb0230e223f45ed',
     armv7l: '835806e05b5fb7054ca5bb06119aa013d556fe2d908bbb64ffb0230e223f45ed',
     x86_64: '823f618c39d999744c11b10de1bf4499e4d130ba29a51f93f922c833b8849d8a'
  })

  depends_on 'cairo' # R
  depends_on 'desktop_file_utils' => :build
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' # R
  depends_on 'gsettings_desktop_schemas' # L
  depends_on 'gspell' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'hunspell' # R
  depends_on 'libgedit_amtk' # R
  depends_on 'libgedit_gtksourceview' # R
  depends_on 'libpeas' # R
  depends_on 'pango' # R
  depends_on 'py3_lxml' => :build
  depends_on 'pygobject' => :build
  depends_on 'tepl_6' # R
  depends_on 'vala' => :build
  depends_on 'yelp_tools' => :build
  gnome

  meson_options '-Drequire_all_tests=false \
    -Dgtk_doc=false \
    -Duser_documentation=true'
end
