require 'buildsystems/meson'

class Libhandy < Meson
  description 'The aim of the handy library is to help with developing UI for mobile devices using GTK/GNOME.'
  homepage 'https://gitlab.gnome.org/GNOME/libhandy/'
  version '1.8.3'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/libhandy.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fe03a956c9c8249e5cf5faac8a9f8cf7b9119c816b3dbe2f4d0172a283355763',
     armv7l: 'fe03a956c9c8249e5cf5faac8a9f8cf7b9119c816b3dbe2f4d0172a283355763',
     x86_64: '1356e5fa0d54329d76250baf3b23b114b9ffee5c5acab55a3bdf7d03d103b4a3'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'fribidi' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glade' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'libjpeg' => :build
  depends_on 'pango' # R
  depends_on 'vala' => :build
  depends_on 'zlibpkg' => :build

  gnome

  meson_options '-Dexamples=false'
end
