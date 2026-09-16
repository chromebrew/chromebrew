require 'buildsystems/meson'

class Gnome_text_editor < Meson
  description 'GNOME Text Editor'
  homepage 'https://gitlab.gnome.org/GNOME/gnome-text-editor'
  version '51.0'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-text-editor.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cfee5b1be52d11de1e6ebebbbd6d5f076ec3b1f40e1aac643b7a39e8455c833d',
     armv7l: 'cfee5b1be52d11de1e6ebebbbd6d5f076ec3b1f40e1aac643b7a39e8455c833d',
     x86_64: 'ef13d8212f0300c33b8148b798574c52516325389d0973531f6a99df24cdd0bf'
  })

  depends_on 'desktop_file_utils' => :build
  depends_on 'editorconfig_core_c' => :executable
  depends_on 'gcc_lib' # R
  depends_on 'glib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
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
