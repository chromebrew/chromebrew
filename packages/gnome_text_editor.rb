require 'buildsystems/meson'

class Gnome_text_editor < Meson
  description 'GNOME Text Editor'
  homepage 'https://gitlab.gnome.org/GNOME/gnome-text-editor'
  version '47.beta'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-text-editor.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4a054cfb5030a01f538cea822bb24986bae41d413ba73d07c55de0e2fbe4803b',
     armv7l: '4a054cfb5030a01f538cea822bb24986bae41d413ba73d07c55de0e2fbe4803b',
     x86_64: '4771dc0e77de5069289161792a1101d0be593df9866315b90755180a2f9b8562'
  })

  depends_on 'cairo' # R
  depends_on 'desktop_file_utils' => :build
  depends_on 'editorconfig_core_c' # R
  depends_on 'enchant' # R
  depends_on 'fontconfig' # R
  depends_on 'fribidi' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'graphene' # R
  depends_on 'gspell' => :build
  depends_on 'gtk4' # R
  depends_on 'gtk_doc' => :build
  depends_on 'gtksourceview_5' # R
  depends_on 'harfbuzz' # R
  depends_on 'ibus' => :build
  depends_on 'icu4c' # R
  depends_on 'libadwaita' # R
  depends_on 'libpeas' => :build
  depends_on 'libxml2' # R
  depends_on 'pango' # R
  depends_on 'pcre2' # R
  depends_on 'pcre' => :build
  depends_on 'py3_pygobject' => :build
  depends_on 'sassc' => :build
  depends_on 'vala' => :build
  depends_on 'vulkan_icd_loader' # R
  depends_on 'yelp_tools' => :build

  gnome
end
