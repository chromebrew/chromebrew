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
    aarch64: 'a1f180e43690a54b65de8606bf4098c190f8e51a0ffccd357af25308adf4173c',
     armv7l: 'a1f180e43690a54b65de8606bf4098c190f8e51a0ffccd357af25308adf4173c',
     x86_64: '8258cfcc36d014370730b4c5c9285ddbbfbe276dc6b8d7e958ee001dfd4519b7'
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

  def self.postinstall
    system "glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas"
  end
end
