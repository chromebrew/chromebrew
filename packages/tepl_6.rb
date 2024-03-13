require 'packagebuildsystems/meson'
class Tepl_6 < Meson
  description 'Library that eases the development of GtkSourceView-based text editors and IDEs'
  homepage 'https://wiki.gnome.org/Projects/Tepl'
  version '6.0.0.0'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/swilmet/tepl.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    i686: 'f98b0034642f3433f036107d710f7c466701f94cea809e83908ada8c98305bc2',
    aarch64: '91d6926ec63368229ac7526d719d15d1e2ae9b5cdb4e6046519792a7ce8f5a8a',
     armv7l: '91d6926ec63368229ac7526d719d15d1e2ae9b5cdb4e6046519792a7ce8f5a8a',
     x86_64: 'cb6aa557f538e25b3b9dff15ec7b02699b8efc13e76749d4b262406b541b577d'
  })

  depends_on 'amtk' => :build
  depends_on 'cairo' => :build
  depends_on 'glib' => :build
  depends_on 'gtk3' => :build
  depends_on 'libgedit_gtksourceview' => :build
  depends_on 'gobject_introspection' => :build
  depends_on 'vala' => :build

  meson_options '-Dgtk_doc=false'
end
