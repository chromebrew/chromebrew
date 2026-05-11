require 'buildsystems/meson'

class Gnome_text_editor < Meson
  description 'GNOME Text Editor'
  homepage 'https://gitlab.gnome.org/GNOME/gnome-text-editor'
  version '50.1'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-text-editor.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5c7f402fbd248df8b88c84dd2b0f98b0eaf5dfc00eafcc08b5de1d87ef778946',
     armv7l: '5c7f402fbd248df8b88c84dd2b0f98b0eaf5dfc00eafcc08b5de1d87ef778946',
     x86_64: '2fcde5047701b79c273d81762293903b174918e8c86dbee68f4b284ec3268bd6'
  })

  depends_on 'desktop_file_utils' => :build
  depends_on 'editorconfig_core_c' => :executable
  depends_on 'gcc_lib' # R
  depends_on 'glib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'gobject_introspection' => :build
  depends_on 'gspell' => :build
  depends_on 'gtk4' => :executable
  depends_on 'gtk_doc' => :build
  depends_on 'gtksourceview_5' => :executable
  depends_on 'ibus' => :build
  depends_on 'libadwaita' => :executable
  depends_on 'libpeas' => :build
  depends_on 'libspelling' => :executable
  depends_on 'pango' => :executable
  depends_on 'pcre' => :build
  depends_on 'py3_pygobject' => :build
  depends_on 'sassc' => :build
  depends_on 'vala' => :build
  depends_on 'yelp_tools' => :build

  gnome
end
