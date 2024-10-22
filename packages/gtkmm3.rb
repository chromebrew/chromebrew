require 'buildsystems/meson'

class Gtkmm3 < Meson
  description 'The Gtkmm3 package provides a C++ interface to GTK+ 3.'
  homepage 'https://www.gtkmm.org/'
  version '3.24.7'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/gtkmm/3.24/gtkmm-3.24.7.tar.xz'
  source_sha256 '1d7a35af9c5ceccacb244ee3c2deb9b245720d8510ac5c7e6f4b6f9947e6789c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0c760e1b3f325ae6f3683797c6f58c4098c843270aafcf1a176346a17e533e99',
     armv7l: '0c760e1b3f325ae6f3683797c6f58c4098c843270aafcf1a176346a17e533e99',
     x86_64: 'fe6a68995f3e0b1f664f702917f0de24773b8d1a37618ba5e06d65631ce2dde7'
  })

  depends_on 'atkmm16' # R
  depends_on 'cairomm_1_0' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glibmm_2_4' # R
  depends_on 'glib' # R
  depends_on 'gtk3' # R
  depends_on 'libsigcplusplus' # R
  depends_on 'pangomm_1_4' # R

  gnome
  no_upstream_update

  meson_options '--default-library=both \
    -Dbuild-documentation=false \
    -Dbuild-demos=false \
    -Dbuild-tests=false'
end
