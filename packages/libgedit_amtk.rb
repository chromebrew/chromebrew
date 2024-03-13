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
    aarch64: '6d3c8ac190895b8065f94c54baa32c3407c474204a58ded15aa850a5a177a176',
      armv7l: '6d3c8ac190895b8065f94c54baa32c3407c474204a58ded15aa850a5a177a176',
      x86_64: '6528fb4e8fc817d21ae245563631eec51954a1b3f75cc5513accca67732452d1'
  })

  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk3' # R
  depends_on 'llvm18_lib' => :build

  meson_options '-Dgtk_doc=false'
end
