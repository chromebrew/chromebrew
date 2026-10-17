require 'buildsystems/meson'

class Libgedit_gtksourceview < Meson
  description 'Gedit Technology - Source code editing widget'
  homepage 'https://gedit-text-editor.org'
  version '299.8.0'
  license 'LGPL2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/World/gedit/libgedit-gtksourceview.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '07fb2aec4e90d5b44fac9e8922c1457ce4ee24def05b8c1b8cdae13ea1ea5c72',
     armv7l: '07fb2aec4e90d5b44fac9e8922c1457ce4ee24def05b8c1b8cdae13ea1ea5c72',
     x86_64: 'f49a51e3a58d53def0f8c358b9791fa7a15ac4b532234a9621593ada092ebf50'
  })

  depends_on 'cairo' => :library
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk3' => :library
  depends_on 'harfbuzz' => :library
  depends_on 'libgedit_amtk' => :library
  depends_on 'libgedit_gfls' => :library
  depends_on 'libxml2' => :library
  depends_on 'pango' => :library

  meson_options '-Dgtk_doc=false'
end
