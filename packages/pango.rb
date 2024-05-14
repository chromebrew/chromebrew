require 'buildsystems/meson'
# build order: harfbuzz => freetype => fontconfig => cairo => pango

class Pango < Meson
  description 'Pango is a library for laying out and rendering of text, with an emphasis on internationalization.'
  homepage 'https://pango.gnome.org/'
  version '1.52.2'
  license 'LGPL-2+ and FTL'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/pango.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bd55b1eb27d8106deaedb2a1af4bacea3c567f5bfbc037d9dde51f11b48e3454',
     armv7l: 'bd55b1eb27d8106deaedb2a1af4bacea3c567f5bfbc037d9dde51f11b48e3454',
     x86_64: 'dac956a0fb4c555d5aa7242876f150961eeb341ac35bda66833d8cfe8380b9e9'
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
