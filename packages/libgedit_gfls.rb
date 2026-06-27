require 'buildsystems/meson'

class Libgedit_gfls < Meson
  description 'A module dedicated to file loading and saving.'
  homepage 'https://gitlab.gnome.org/World/gedit/libgedit-gfls'
  version '0.4.2'
  license 'LGPL-3.0-or-later'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/World/gedit/libgedit-gfls.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ab040ecc921ca3e46d193c5192d89e4ac770e33d7ecc1d7d6241f64d7b022726',
     armv7l: 'ab040ecc921ca3e46d193c5192d89e4ac770e33d7ecc1d7d6241f64d7b022726',
     x86_64: '41f639789271aafec0ef7fd7c114078b92f6e212d740459583ed779b00a2aab2'
  })

  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gobject_introspection'
  depends_on 'gtk3'

  meson_options '-Dgtk_doc=false'
end
