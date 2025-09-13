require 'buildsystems/meson'

class Tepl_6 < Meson
  description 'Library that eases the development of GtkSourceView-based text editors and IDEs'
  homepage 'https://gitlab.gnome.org/World/gedit/libgedit-tepl'
  version "6.13.0-#{CREW_ICU_VER}"
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/World/gedit/libgedit-tepl.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7f3bbee8e7ba59106959ee11dad127f761ac66e8ba0d926f8a82f0eb6cdfbeae',
     armv7l: '7f3bbee8e7ba59106959ee11dad127f761ac66e8ba0d926f8a82f0eb6cdfbeae',
     x86_64: '640e74588abc0727dd353a3b1559378b56570aa57a35ab4c590b08c95ba2800c'
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
