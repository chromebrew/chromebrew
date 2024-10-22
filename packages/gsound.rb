require 'buildsystems/meson'

class Gsound < Meson
  description 'GSound is a small library for playing system sounds.'
  homepage 'https://wiki.gnome.org/Projects/GSound'
  version '1.0.3'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/gsound.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bdc85dfd9d5dc8c9338ad38250ad2997f04693e8b8fb2577cbe2702a2a0c7358',
     armv7l: 'bdc85dfd9d5dc8c9338ad38250ad2997f04693e8b8fb2577cbe2702a2a0c7358',
     x86_64: 'a5493ea8afbe4b7e869731e221dc29aba02752f72aeb6db60ffc2a64560b5d7f'
  })

  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'libcanberra' # R

  gnome

  meson_options '-Dgtk_doc=false'
end
