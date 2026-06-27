require 'buildsystems/meson'

class Libgedit_gtksourceview < Meson
  description 'Gedit Technology - Source code editing widget'
  homepage 'https://gedit-text-editor.org'
  version '299.7.1'
  license 'LGPL2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/World/gedit/libgedit-gtksourceview.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cc9a02d23ec2433cfe732d89ecb1d3acf2cbce67e6fefbda1570d245fa9681c1',
     armv7l: 'cc9a02d23ec2433cfe732d89ecb1d3acf2cbce67e6fefbda1570d245fa9681c1',
     x86_64: '41ffff0d8bedb569f1caf66db12082330f25169ef7879292256f7536506ac544'
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
