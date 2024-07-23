require 'buildsystems/meson'

class Libgedit_amtk < Meson
  description 'Actions, Menus and Toolbars Kit for GTK+ applications'
  homepage 'https://gedit-technology.github.io'
  version '5.8.0'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/gedit-technology/libgedit-amtk.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e1311b5685cc0137cac447e126344664bae26c23d36ba85c28ee69c16527b572',
      armv7l: 'e1311b5685cc0137cac447e126344664bae26c23d36ba85c28ee69c16527b572',
      x86_64: '6bbeb30d50b1f2d254056db4fb86e6b74bb75359f7d4bba1d6142dda92f24bcb'
  })

  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk3' # R
  depends_on 'llvm18_lib' => :build

  meson_options '-Dgtk_doc=false'
end
