require 'buildsystems/meson'

class Gexiv2 < Meson
  description 'gexiv2 is a GObject wrapper around the Exiv2 photo metadata library.'
  homepage 'https://wiki.gnome.org/Projects/gexiv2/'
  version '0.14.6'
  license 'LGPL-2.1+ and GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gexiv2.git'
  git_hashtag "gexiv2-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1948fbe179b802852811e91322676660acff7a345c12a04b93069863a2ed430c',
     armv7l: '1948fbe179b802852811e91322676660acff7a345c12a04b93069863a2ed430c',
     x86_64: '2a25ac5db8d59dd65d75d4df4a37cb35449bf06f065c1fd6764f64bd6e0b4e25'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'libexiv2' # R

  gnome
end
