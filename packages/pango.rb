require 'buildsystems/meson'
# build order: harfbuzz => freetype => fontconfig => cairo => pango

class Pango < Meson
  description 'Pango is a library for laying out and rendering of text, with an emphasis on internationalization.'
  homepage 'https://pango.gnome.org/'
  version '1.56.3'
  license 'LGPL-2+ and FTL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/pango.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '29bce5f71c88cdd92df459c350f73a89b7e2909de05a80f2f206f380dfe3f77f',
     armv7l: '29bce5f71c88cdd92df459c350f73a89b7e2909de05a80f2f206f380dfe3f77f',
     x86_64: '2326ef48c5a386ecaa45498e8135ac8dd9e363179b22d15deaa4eec0dfe5ac0c'
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
      -Dintrospection=enabled \
      -Dlibthai=disabled'
end
