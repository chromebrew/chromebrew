require 'buildsystems/meson'
# build order: harfbuzz => freetype => fontconfig => cairo => pango

class Pango < Meson
  description 'Pango is a library for laying out and rendering of text, with an emphasis on internationalization.'
  homepage 'https://www.pango.org/'
  version '1.57.1'
  license 'LGPL-2+ and FTL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/pango.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '99a46a9dc8a7becd264e77626144bbccc57590582e35e3c7ab59190a5370d396',
     armv7l: '99a46a9dc8a7becd264e77626144bbccc57590582e35e3c7ab59190a5370d396',
     x86_64: '1c9bd397e131506cc4025416b44f937c9003d3511e7e93d356f9432b743dbb19'
  })

  depends_on 'cairo' => :library
  depends_on 'fontconfig' => :library
  depends_on 'freetype' => :library
  depends_on 'fribidi' => :library
  depends_on 'gcc_lib' # R
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
