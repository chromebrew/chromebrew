require 'buildsystems/meson'
# build order: harfbuzz => freetype => fontconfig => cairo => pango

class Pango < Meson
  description 'Pango is a library for laying out and rendering of text, with an emphasis on internationalization.'
  homepage 'https://pango.gnome.org/'
  version '1.56.0'
  license 'LGPL-2+ and FTL'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/pango.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '387a42e33a8410c26b6f7a13bd6d0f5d1145aa5aea50c4a3379056c3111e482e',
     armv7l: '387a42e33a8410c26b6f7a13bd6d0f5d1145aa5aea50c4a3379056c3111e482e',
     x86_64: 'd25a7a18dbb1e6a174f629549c013d654d859358457d93e0360d2c266ed4abdb'
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

  meson_options '-Dbuild-examples=false \
      -Dbuild-testsuite=false \
      -Dcairo=enabled \
      -Ddocumentation=false \
      -Dfontconfig=enabled \
      -Dfreetype=enabled \
      -Dlibthai=disabled'
end
