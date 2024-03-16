require 'buildsystems/meson'

class Gexiv2 < Meson
  description 'gexiv2 is a GObject wrapper around the Exiv2 photo metadata library.'
  homepage 'https://wiki.gnome.org/Projects/gexiv2/'
  version '0.14.2'
  license 'LGPL-2.1+ and GPL-2'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gexiv2.git'
  git_hashtag "gexiv2-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ab994a2e5b9354599f4603e16091b4503ea375bb805f25edc5bee32fa3655c43',
     armv7l: 'ab994a2e5b9354599f4603e16091b4503ea375bb805f25edc5bee32fa3655c43',
       i686: 'f30043519e9bfd162de74b32c1b788d7876eaf9a03b3dfdcd384fda40455ea84',
     x86_64: '7f2799dabed00079324a63eaed08490316922ec4af3336035fb2c0caa102a785'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'libexiv2' # R

  gnome
end
