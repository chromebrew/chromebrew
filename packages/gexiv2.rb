require 'buildsystems/meson'

class Gexiv2 < Meson
  description 'gexiv2 is a GObject wrapper around the Exiv2 photo metadata library.'
  homepage 'https://wiki.gnome.org/Projects/gexiv2/'
  version '0.14.0'
  license 'LGPL-2.1+ and GPL-2'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gexiv2.git'
  git_hashtag "gexiv2-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '25bf888e23ceedb54f8adfa3b87737e66ad03ef9e6fc6292bb5888ea443ad8f7',
     armv7l: '25bf888e23ceedb54f8adfa3b87737e66ad03ef9e6fc6292bb5888ea443ad8f7',
       i686: 'f30043519e9bfd162de74b32c1b788d7876eaf9a03b3dfdcd384fda40455ea84',
     x86_64: '1a1f1d403dd3f65e8d84001a8cefb35ec7ab42fcf1dc865181221d8dacaa3c76'
  })

  depends_on 'libexiv2' => :build
  depends_on 'gobject_introspection' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R

  gnome
end
