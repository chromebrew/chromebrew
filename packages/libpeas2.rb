require 'buildsystems/meson'

class Libpeas2 < Meson
  description 'A GObject plugins library'
  homepage 'https://gitlab.gnome.org/GNOME/libpeas'
  version '2.0.1'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/libpeas.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '214bf9f554c736aafc293b2d9bd79e0a3e90e355b660f7aedff8434970c062cb',
     armv7l: '214bf9f554c736aafc293b2d9bd79e0a3e90e355b660f7aedff8434970c062cb',
     x86_64: 'f8c5e4fa0cb1f524273b566c1572f0af6cdc930af85eecd88773d2d7383d7071'
  })

  depends_on 'gcc_lib' # R
  depends_on 'gjs' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'js115' # R
  depends_on 'luajit_lgi' => :build
  depends_on 'luajit' # R
  depends_on 'py3_gi_docgen' => :build
  depends_on 'pygobject' => :build
  depends_on 'python3' # R
  depends_on 'vala' => :build

  gnome
end
