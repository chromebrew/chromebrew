require 'buildsystems/meson'

class Libgedit_gtksourceview < Meson
  description 'Gedit Technology - Source code editing widget'
  homepage 'https://gedit-text-editor.org'
  version '299.7.0'
  license 'LGPL2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/World/gedit/libgedit-gtksourceview.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9f5d353b062ff0af49aa28396da7a4e8215735f53465fef7dac42e30e41ab509',
     armv7l: '9f5d353b062ff0af49aa28396da7a4e8215735f53465fef7dac42e30e41ab509',
     x86_64: 'a559a8adef6417997609376acc1ee04ef4a1c9bcf1cb59ac6383c10564894d93'
  })

  depends_on 'cairo' => :library
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk3' => :library
  depends_on 'harfbuzz' => :library
  depends_on 'libgedit_amtk' => :library
  depends_on 'libgedit_gfls' => :library
  depends_on 'libxml2' => :library
  depends_on 'pango' => :library

  meson_options '-Dgtk_doc=false'
end
