require 'buildsystems/meson'
# build order: harfbuzz => freetype => fontconfig => cairo => pango

class Pango < Meson
  description 'Pango is a library for laying out and rendering of text, with an emphasis on internationalization.'
  homepage 'https://www.pango.org/'
  version '1.58.1'
  license 'LGPL-2+ and FTL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/pango.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '44d8bba68f97101c3e41e8dc5196b773b28bbc085e811200d4d821c88160d631',
     armv7l: '44d8bba68f97101c3e41e8dc5196b773b28bbc085e811200d4d821c88160d631',
     x86_64: 'b40610509755a4e6472cc89f354d07554c4af3e9158b5e8982c7b494a44e8e27'
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
