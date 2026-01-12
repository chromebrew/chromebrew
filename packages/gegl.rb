require 'buildsystems/meson'

class Gegl < Meson
  description 'GEGL (Generic Graphics Library) is a data flow based image processing framework, providing floating point processing and non-destructive image processing capabilities to GNU Image Manipulation Program and other projects.'
  homepage 'https://gegl.org/'
  version '0.4.66'
  license 'GPL-3+ and LGPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gegl.git'
  git_hashtag "GEGL_#{version.split('-').first.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8211d0815e20b090ad8bcc63fd9c96874415accf1aee76e0fd7926e0e8982a46',
     armv7l: '8211d0815e20b090ad8bcc63fd9c96874415accf1aee76e0fd7926e0e8982a46',
     x86_64: 'd3d171d2c0a23a99f2b3e356f60e22a0feb8229ff6272ee34baa10e521abc619'
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
