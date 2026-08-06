require 'buildsystems/meson'
# build order: harfbuzz => freetype => fontconfig => cairo => pango

class Pango < Meson
  description 'Pango is a library for laying out and rendering of text, with an emphasis on internationalization.'
  homepage 'https://www.pango.org/'
  version '1.58.2'
  license 'LGPL-2+ and FTL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/pango.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8c4997e4e0a65d1caa4083d79a92c43c0351a88e144af16e2f266f0f3315b1a1',
     armv7l: '8c4997e4e0a65d1caa4083d79a92c43c0351a88e144af16e2f266f0f3315b1a1',
     x86_64: '0f32e2a530f1f7051758bb25cb49aa7e0c68b8c768d81bdab6df067d1dfcae23'
  })

  depends_on 'cairo' => :library
  depends_on 'fontconfig' => :library
  depends_on 'freetype' => :library
  depends_on 'fribidi' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gobject_introspection' => :build # add this package to build gtk+, avoid compilation error
  depends_on 'harfbuzz' => :library
  depends_on 'libx11' => :library
  depends_on 'libxdmcp' => :build
  depends_on 'libxft' => :library
  depends_on 'libxrender' => :library
  depends_on 'xorg_proto' => :build

  meson_options '-Dbuild-examples=false \
      -Dbuild-testsuite=false \
      -Dcairo=enabled \
      -Ddocumentation=false \
      -Dfontconfig=enabled \
      -Dfreetype=enabled \
      -Dintrospection=enabled \
      -Dlibthai=disabled'
end
