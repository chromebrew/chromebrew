require 'buildsystems/meson'

class Tepl_6 < Meson
  description 'Library that eases the development of GtkSourceView-based text editors and IDEs'
  homepage 'https://gitlab.gnome.org/World/gedit/libgedit-tepl'
  version "6.10.0-#{CREW_ICU_VER}"
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/World/gedit/libgedit-tepl.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '90aee89081b04bc5cd5acd569f08f8daa283dfeee45252ddb0d3cd66cb8ab7fb',
     armv7l: '90aee89081b04bc5cd5acd569f08f8daa283dfeee45252ddb0d3cd66cb8ab7fb',
     x86_64: '8bb15f270de6bc2ed4ad6177e97c11d8f9dc38dce9dbe154e17868ce57646ec5'
  })

  depends_on 'cairo' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gsettings_desktop_schemas' => :build
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'icu4c' # R
  depends_on 'libgedit_amtk' # R
  depends_on 'libgedit_gfls' # R
  depends_on 'libgedit_gtksourceview' # R
  depends_on 'libhandy' => :build
  depends_on 'pango' # R
  depends_on 'vala' => :build
  depends_on 'libhandy' # R

  gnome

  meson_options '-Dgtk_doc=false'
end
