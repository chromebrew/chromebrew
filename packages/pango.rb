require 'buildsystems/meson'
# build order: harfbuzz => freetype => fontconfig => cairo => pango

class Pango < Meson
  description 'Pango is a library for laying out and rendering of text, with an emphasis on internationalization.'
  homepage 'https://pango.gnome.org/'
  version '1.56.2'
  license 'LGPL-2+ and FTL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/pango.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cca03bdca509d258a566f0a4c792dd9f5cd637639aa84d623ba526c5b5cd8c9c',
     armv7l: 'cca03bdca509d258a566f0a4c792dd9f5cd637639aa84d623ba526c5b5cd8c9c',
     x86_64: 'fd7996e1a199c7918210ae757b5aaa6dcca35d756aa02329a5e00116a8bd9fca'
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
