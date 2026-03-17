require 'buildsystems/meson'

class Gnome_text_editor < Meson
  description 'GNOME Text Editor'
  homepage 'https://gitlab.gnome.org/GNOME/gnome-text-editor'
  version '50.0'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-text-editor.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '052cdb67487e3c3a9ac8d4f48f5ad2fdd6b4c73b424ac8b21c0b83e5e4098d8b',
     armv7l: '052cdb67487e3c3a9ac8d4f48f5ad2fdd6b4c73b424ac8b21c0b83e5e4098d8b',
     x86_64: 'aa742ff8c9c4886f889714ce9c50d5831204accc3e06aa4eefd4aba294929277'
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
