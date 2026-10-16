require 'buildsystems/meson'

class Libgedit_gfls < Meson
  description 'A module dedicated to file loading and saving.'
  homepage 'https://gitlab.gnome.org/World/gedit/libgedit-gfls'
  version '0.5.0'
  license 'LGPL-3.0-or-later'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/World/gedit/libgedit-gfls.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cbfd5480ddfe5a70acca31e753450265ef11a5f8692cd35f5a20084559fcf283',
     armv7l: 'cbfd5480ddfe5a70acca31e753450265ef11a5f8692cd35f5a20084559fcf283',
     x86_64: 'e2b65cbc96900225217612aba66863e746de6cca35a054d6f1b33f471bb82fdd'
  })

  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gobject_introspection'
  depends_on 'gtk3'

  meson_options '-Dgtk_doc=false'
end
