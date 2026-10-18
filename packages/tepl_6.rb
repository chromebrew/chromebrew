require 'buildsystems/meson'

class Tepl_6 < Meson
  description 'Library that eases the development of GtkSourceView-based text editors and IDEs'
  homepage 'https://gitlab.gnome.org/World/gedit/libgedit-tepl'
  version "6.15.0-#{CREW_ICU_VER}"
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/World/gedit/libgedit-tepl.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4f5cb3e6f8e109caa7be8bbe96fa15ca7aa360c692f7a5cec611e8eecb6def32',
     armv7l: '4f5cb3e6f8e109caa7be8bbe96fa15ca7aa360c692f7a5cec611e8eecb6def32',
     x86_64: 'c5f74f867e112395d2ee5a36a3a8b5f7608d00a0b936ab6160c081e10dcac446'
  })

  depends_on 'cairo' => :library
  depends_on 'gcc_lib' # R
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
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
