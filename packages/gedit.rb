require 'buildsystems/meson'

class Gedit < Meson
  description 'GNOME Text Editor'
  homepage 'https://wiki.gnome.org/Apps/Gedit'
  version '49.0'
  license 'GPL-2+ CC-BY-SA-3.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gedit.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ac6287afc679ad75a753df15741126b4be8fc650bfcaeea1f4cf47c77467ef5c',
     armv7l: 'ac6287afc679ad75a753df15741126b4be8fc650bfcaeea1f4cf47c77467ef5c',
     x86_64: 'b66022b46a4f7dee6db5d51bba361ce0ab25d25a526dbfe55b6c12b1b8c7b811'
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
  depends_on 'libgedit_gtksourceview' # R
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
