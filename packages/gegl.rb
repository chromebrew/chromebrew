require 'buildsystems/meson'

class Gegl < Meson
  description 'GEGL (Generic Graphics Library) is a data flow based image processing framework, providing floating point processing and non-destructive image processing capabilities to GNU Image Manipulation Program and other projects.'
  homepage 'https://gegl.org/'
  version '0.4.64'
  license 'GPL-3+ and LGPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://download.gimp.org/pub/gegl/#{version.rpartition('.')[0]}/gegl-#{version}.tar.xz"
  source_sha256 '0de1c9dd22c160d5e4bdfc388d292f03447cca6258541b9a12fed783d0cf7c60'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '73d655b1693f1c4f95cdf5196086cddfdf9668105083b17882a6983f22ad6b91',
     armv7l: '73d655b1693f1c4f95cdf5196086cddfdf9668105083b17882a6983f22ad6b91',
     x86_64: '88fa157437c1ef69ba6fa307127bc23465e417bb857499213e9dbbfc311eee01'
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
  depends_on 'libjpeg_turbo' # R
  depends_on 'libpng' # R
  depends_on 'librsvg' # R
  depends_on 'libtiff' # R
  depends_on 'libwebp' # R
  depends_on 'luajit' => :build
  depends_on 'openexr' # R
  depends_on 'pango' # R
  depends_on 'poppler' # R
  depends_on 'py3_asciidoc' => :build
  depends_on 'sdl2' # R
  depends_on 'source_highlight' => :build
  depends_on 'zlib' # R

  meson_options '-Dvapigen=disabled'
end
