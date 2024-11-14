require 'buildsystems/meson'

class Gegl < Meson
  description 'GEGL (Generic Graphics Library) is a data flow based image processing framework, providing floating point processing and non-destructive image processing capabilities to GNU Image Manipulation Program and other projects.'
  homepage 'https://gegl.org/'
  version '0.4.50'
  license 'GPL-3+ and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://download.gimp.org/pub/gegl/0.4/gegl-0.4.50.tar.xz'
  source_sha256 '418c26d94be8805d7d98f6de0c6825ca26bd74fcacb6c188da47533d9ee28247'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f3e7f6d7bf087ae590937aa885ce6b9d6fe19e32fdffd25375b5f5a98facdec4',
     armv7l: 'f3e7f6d7bf087ae590937aa885ce6b9d6fe19e32fdffd25375b5f5a98facdec4',
     x86_64: '476e5af95f7da7881e222d0d2b12a5186e132c170ee1d78bc667104688961fc8'
  })

  depends_on 'py3_asciidoc' => :build
  depends_on 'babl' # R
  depends_on 'cairo' # R
  depends_on 'enscript' => :build
  depends_on 'ffmpeg' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'gexiv2' => :build
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'graphviz' => :build # for dot
  depends_on 'harfbuzz' # R
  depends_on 'jasper' # R
  depends_on 'json_glib' # R
  depends_on 'lcms' # R
  depends_on 'libjpeg_turbo' # R
  depends_on 'libpng' # R
  depends_on 'librsvg' # R
  depends_on 'libsdl2' # R
  depends_on 'libtiff' # R
  depends_on 'libwebp' # R
  depends_on 'luajit' => :build
  depends_on 'openexr' # R
  depends_on 'pango' # R
  depends_on 'poppler' # R
  depends_on 'source_highlight' => :build
  depends_on 'vala' => :build
  depends_on 'zlib' # R

  meson_options '-Dlibjpeg=enabled \
      -Dlibpng=enabled'
end
