require 'buildsystems/meson'

class Tepl_6 < Meson
  description 'Library that eases the development of GtkSourceView-based text editors and IDEs'
  homepage 'https://github.com/gedit-technology/libgedit-tepl'
  version '6.8.0'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/gedit-technology/libgedit-tepl.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '80740c34d9709d82a5a77a9d2c55e99b38d4bab611d7ffb0fd6147cfcc1c5401',
     armv7l: '80740c34d9709d82a5a77a9d2c55e99b38d4bab611d7ffb0fd6147cfcc1c5401',
     x86_64: '3ae27a5c42cd3095d98ad84bbee34834fbe167335b7684d2120850c11b4a7844'
  })

  depends_on 'cairo' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'icu4c' # R
  depends_on 'libgedit_amtk' # R
  depends_on 'libgedit_gtksourceview' # R
  depends_on 'pango' # R
  depends_on 'vala' => :build

  gnome

  meson_options '-Dgtk_doc=false'
end
