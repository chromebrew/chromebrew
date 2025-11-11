require 'buildsystems/meson'

class Gnome_text_editor < Meson
  description 'GNOME Text Editor'
  homepage 'https://gitlab.gnome.org/GNOME/gnome-text-editor'
  version '49.0'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-text-editor.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fddeb7ccbe1b503acf71f5e89bceeb3fd00762bb38d211679a772c900a316535',
     armv7l: 'fddeb7ccbe1b503acf71f5e89bceeb3fd00762bb38d211679a772c900a316535',
     x86_64: 'c20b9b9bcd10788d18f0495803400a0963960b6290298fb50d86df14fb3dbf1d'
  })

  depends_on 'desktop_file_utils' => :build
  depends_on 'editorconfig_core_c' # R
  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gspell' => :build
  depends_on 'gtk4' # R
  depends_on 'gtk_doc' => :build
  depends_on 'gtksourceview_5' # R
  depends_on 'ibus' => :build
  depends_on 'libadwaita' # R
  depends_on 'libpeas' => :build
  depends_on 'libspelling' # R
  depends_on 'pango' # R
  depends_on 'pcre' => :build
  depends_on 'py3_pygobject' => :build
  depends_on 'sassc' => :build
  depends_on 'vala' => :build
  depends_on 'yelp_tools' => :build

  gnome
end
