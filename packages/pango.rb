require 'buildsystems/meson'
# build order: harfbuzz => freetype => fontconfig => cairo => pango

class Pango < Meson
  description 'Pango is a library for laying out and rendering of text, with an emphasis on internationalization.'
  homepage 'https://pango.gnome.org/'
  version '1.52.1'
  license 'LGPL-2+ and FTL'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/pango.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c29f6ef32a0485b110a3b356ee5dc6a2f3fbdbae36e1522fb7cea721467879ca',
     armv7l: 'c29f6ef32a0485b110a3b356ee5dc6a2f3fbdbae36e1522fb7cea721467879ca',
     x86_64: '88669ba12416df9d44d70a79eb2ae081e6473bfe05054012589fcca9fb32e4a0'
  })

  depends_on 'cairo' # R
  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'fribidi' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build # add this package to build gtk+, avoid compilation error
  depends_on 'harfbuzz' # R
  depends_on 'libx11' # R
  depends_on 'libxdmcp' => :build
  depends_on 'libxft' # R
  depends_on 'libxrender' # R
  depends_on 'xorg_proto' => :build

  meson_options '-Dinstall-tests=false \
      -Dcairo=enabled \
      -Dfreetype=enabled \
      -Dfontconfig=enabled \
      -Dlibthai=disabled \
      -Dgtk_doc=false'
end
