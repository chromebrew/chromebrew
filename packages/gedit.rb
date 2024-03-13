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
    aarch64: '6ea2d20c4559494331e6236f717ce1eb95887942e63cf814d5b214dfd48fbaf8',
     armv7l: '6ea2d20c4559494331e6236f717ce1eb95887942e63cf814d5b214dfd48fbaf8',
     x86_64: '5994fc28d453006ddafc6605ef52828c44911c41ad2c1c9f9c045646f19833c0'
  })

  depends_on 'cairo' # R
  depends_on 'desktop_file_utils' => :build
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' # R
  depends_on 'gsettings_desktop_schemas' # L
  depends_on 'gspell' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'libgedit_amtk' # R
  depends_on 'libgedit_gtksourceview' # R
  depends_on 'libpeas' # R
  depends_on 'pango' # R
  depends_on 'py3_lxml' => :build
  depends_on 'pygobject' => :build
  depends_on 'tepl_6' # R
  depends_on 'vala' => :build
  depends_on 'yelp_tools' => :build

  meson_options '-Drequire_all_tests=false \
    -Dgtk_doc=false \
    -Duser_documentation=true'
end
