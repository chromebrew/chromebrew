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
    aarch64: '36727139e79479954df6068874ce34cdfc4c1275a92ecd83967d0c46bb6e1be5',
     armv7l: '36727139e79479954df6068874ce34cdfc4c1275a92ecd83967d0c46bb6e1be5',
     x86_64: '00cdf9424f455b67eaea339c0f9b8f15e637ddbe4fd329e8b034371bb6a5553c'
  })

  depends_on 'cairo' # R
  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gsettings_desktop_schemas' => :build
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'icu4c' # R
  depends_on 'libgedit_amtk' # R
  depends_on 'libgedit_gfls' # R
  depends_on 'libgedit_gtksourceview' # R
  depends_on 'libhandy' # R
  depends_on 'pango' # R
  depends_on 'vala' => :build

  gnome

  meson_options '-Dgtk_doc=false'
end
