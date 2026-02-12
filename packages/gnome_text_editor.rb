require 'buildsystems/meson'

class Gnome_text_editor < Meson
  description 'GNOME Text Editor'
  homepage 'https://gitlab.gnome.org/GNOME/gnome-text-editor'
  version '49.1'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-text-editor.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '76555852ae78f41566b9e00934a35d08f0f31b643aab83d866e0ad3ba1231a2f',
     armv7l: '76555852ae78f41566b9e00934a35d08f0f31b643aab83d866e0ad3ba1231a2f',
     x86_64: '700d0f68ede8334435f854f28f94a621a3b7a10be6246c92013267691eda88c6'
  })

  depends_on 'desktop_file_utils' => :build
  depends_on 'editorconfig_core_c' => :executable_only
  depends_on 'gcc_lib' # R
  depends_on 'glib' => :executable_only
  depends_on 'glibc' => :executable_only
  depends_on 'gobject_introspection' => :build
  depends_on 'gspell' => :build
  depends_on 'gtk4' => :executable_only
  depends_on 'gtk_doc' => :build
  depends_on 'gtksourceview_5' => :executable_only
  depends_on 'ibus' => :build
  depends_on 'libadwaita' => :executable_only
  depends_on 'libpeas' => :build
  depends_on 'libspelling' => :executable_only
  depends_on 'pango' => :executable_only
  depends_on 'pcre' => :build
  depends_on 'py3_pygobject' => :build
  depends_on 'sassc' => :build
  depends_on 'vala' => :build
  depends_on 'yelp_tools' => :build

  gnome
end
