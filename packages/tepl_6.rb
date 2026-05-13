require 'buildsystems/meson'

class Tepl_6 < Meson
  description 'Library that eases the development of GtkSourceView-based text editors and IDEs'
  homepage 'https://gitlab.gnome.org/World/gedit/libgedit-tepl'
  version "6.14.0-#{CREW_ICU_VER}"
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/World/gedit/libgedit-tepl.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b005aca9aae67edd24572a1f9b8a5d960240420a0227b046a39fafb53e769d40',
     armv7l: 'b005aca9aae67edd24572a1f9b8a5d960240420a0227b046a39fafb53e769d40',
     x86_64: '53b79efaf94978be51c25644d43df183d88272d989c9488779b757211c33cf63'
  })

  depends_on 'cairo' => :library
  depends_on 'gcc_lib' # R
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'gobject_introspection' => :build
  depends_on 'gsettings_desktop_schemas' => :build
  depends_on 'gtk3' => :library
  depends_on 'harfbuzz' # R
  depends_on 'icu4c' => :library
  depends_on 'libgedit_amtk' => :library
  depends_on 'libgedit_gfls' => :library
  depends_on 'libgedit_gtksourceview' => :library
  depends_on 'libhandy' => :library
  depends_on 'pango' => :library
  depends_on 'vala' => :build

  gnome

  meson_options '-Dgtk_doc=false'
end
