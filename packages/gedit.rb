require 'buildsystems/meson'

class Gedit < Meson
  description 'GNOME Text Editor'
  homepage 'https://wiki.gnome.org/Apps/Gedit'
  version '48.2'
  license 'GPL-2+ CC-BY-SA-3.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gedit.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b2f680df1b9d04e1265deb33c369dcc0ae21fb53d00b24f8b390c0c76474efb7',
     armv7l: 'b2f680df1b9d04e1265deb33c369dcc0ae21fb53d00b24f8b390c0c76474efb7',
     x86_64: '7dfd711561470d782f37feb7d97510d9a2db059c7cd5b1dccbc7b023097a5cca'
  })

  depends_on 'cairo' # R
  depends_on 'desktop_file_utils' => :build
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gsettings_desktop_schemas' # L
  depends_on 'gspell' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'libpeas' # R
  depends_on 'pango' # R
  depends_on 'py3_lxml' => :build
  depends_on 'py3_pygobject' => :build
  depends_on 'tepl_6' # R
  depends_on 'vala' => :build
  depends_on 'yelp_tools' => :build

  gnome

  meson_options '-Drequire_all_tests=false \
    -Dgtk_doc=false \
    -Duser_documentation=true'
end
