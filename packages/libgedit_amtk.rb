require 'buildsystems/meson'

class Libgedit_amtk < Meson
  description 'Actions, Menus and Toolbars Kit for GTK+ applications'
  homepage 'https://gedit-technology.github.io'
  version '5.9.1'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/World/gedit/libgedit-amtk.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fedcc92166518b7291b4def67647730048305246e4af11d845f3eb53f2033b7d',
     armv7l: 'fedcc92166518b7291b4def67647730048305246e4af11d845f3eb53f2033b7d',
     x86_64: 'e1895ca9a0816aec23fc128edcc1812c97a94be48694f3176a9775d6b044108e'
  })

  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk3' # R
  depends_on 'llvm_lib' => :build

  meson_options '-Dgtk_doc=false'
end
