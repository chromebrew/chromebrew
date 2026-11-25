require 'buildsystems/meson'

class Libgedit_gfls < Meson
  description 'A module dedicated to file loading and saving.'
  homepage 'https://gitlab.gnome.org/World/gedit/libgedit-gfls'
  version '0.5.1'
  license 'LGPL-3.0-or-later'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/World/gedit/libgedit-gfls.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4f773d02462ebcde69f00aa2251818cf826760e1526b5b79b30876cb0681e0f6',
     armv7l: '4f773d02462ebcde69f00aa2251818cf826760e1526b5b79b30876cb0681e0f6',
     x86_64: '3d515324355ab17f3ae4a6d6005f94a88d5575a35b2add45d0b76960134888bf'
  })

  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gobject_introspection'
  depends_on 'gtk3'

  meson_options '-Dgtk_doc=false'
end
