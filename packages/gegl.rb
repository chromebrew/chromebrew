require 'buildsystems/meson'

class Gegl < Meson
  description 'GEGL (Generic Graphics Library) is a data flow based image processing framework, providing floating point processing and non-destructive image processing capabilities to GNU Image Manipulation Program and other projects.'
  homepage 'https://gegl.org/'
  version '0.4.54'
  license 'GPL-3+ and LGPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://download.gimp.org/pub/gegl/#{version.rpartition('.')[0]}/gegl-#{version}.tar.xz"
  source_sha256 '418c26d94be8805d7d98f6de0c6825ca26bd74fcacb6c188da47533d9ee28247'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fa0d3a8e0c6b229dc866f029c44c0865df03d992f54e29276a99d73cb5512405',
     armv7l: 'fa0d3a8e0c6b229dc866f029c44c0865df03d992f54e29276a99d73cb5512405',
     x86_64: '38f9c9cca4573d669e5008d59b6e89f2c0308652e89c7d9fa701c1a0aab7e3ea'
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
