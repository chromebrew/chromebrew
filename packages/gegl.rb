require 'buildsystems/meson'

class Gegl < Meson
  description 'GEGL (Generic Graphics Library) is a data flow based image processing framework, providing floating point processing and non-destructive image processing capabilities to GNU Image Manipulation Program and other projects.'
  homepage 'https://gegl.org/'
  version '0.4.64-1'
  license 'GPL-3+ and LGPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gegl.git'
  git_hashtag "GEGL_#{version.split('-').first.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3d033f108960c738204f59a67d8a0f7e6105866fd674426aea42497ae436ea3f',
     armv7l: '3d033f108960c738204f59a67d8a0f7e6105866fd674426aea42497ae436ea3f',
     x86_64: '60a33705c2931ee551ab26d40b2d5e2a34f63ac5865c56c6724992eaec28a04d'
  })

  depends_on 'babl' # R
  depends_on 'cairo' # R
  depends_on 'enscript' => :build
  depends_on 'ffmpeg' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'gexiv2' => :build
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'graphviz' => :build # for dot
  depends_on 'harfbuzz' # R
  depends_on 'jasper' # R
  depends_on 'json_glib' # R
  depends_on 'lcms' # R
  depends_on 'lensfun' => :build
  depends_on 'libjpeg_turbo' # R
  depends_on 'libpng' # R
  depends_on 'libraw' # R
  depends_on 'librsvg' # R
  depends_on 'libspiro' # R
  depends_on 'libtheora' => :build
  depends_on 'libtiff' # R
  depends_on 'libwebp' # R
  depends_on 'luajit' => :build
  depends_on 'openexr' # R
  depends_on 'pango' # R
  depends_on 'poppler' # R
  depends_on 'py3_asciidoc' => :build
  depends_on 'sdl2' # R
  depends_on 'source_highlight' => :build
  depends_on 'suitesparse' # R
  depends_on 'vala' => :build
  depends_on 'w3m' => :build
  depends_on 'zlib' # R
end
