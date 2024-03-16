require 'buildsystems/meson'

class Gnome_text_editor < Meson
  description 'GNOME Text Editor'
  homepage 'https://gitlab.gnome.org/GNOME/gnome-text-editor'
  version '46.0'
  license 'GPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-text-editor.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8b870b1ce0e78ab2c07b37c3b1681912f49510dc02a771defb13832ae901be45',
     armv7l: '8b870b1ce0e78ab2c07b37c3b1681912f49510dc02a771defb13832ae901be45',
     x86_64: 'fd1ac48f213c3ca2c7f3f51bd5d2a2b5a470cec94876fc6fc87e5aa66f41cb12'
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
  depends_on 'pygobject' => :build
  depends_on 'vala' => :build
  depends_on 'vulkan_icd_loader' # R
  depends_on 'yelp_tools' => :build

  gnome
end
