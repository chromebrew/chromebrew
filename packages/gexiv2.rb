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
    aarch64: 'a4ac4c82e1abb0286af73a5d68e60e670ffa3782e136744d8c8336c7a89e22e1',
     armv7l: 'a4ac4c82e1abb0286af73a5d68e60e670ffa3782e136744d8c8336c7a89e22e1',
       i686: 'f30043519e9bfd162de74b32c1b788d7876eaf9a03b3dfdcd384fda40455ea84',
     x86_64: 'e6acc6a7708ebbc023db7c40605ac361dce7c9b50a56cb611cc2317168540bab'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'libexiv2' # R

  gnome
end
