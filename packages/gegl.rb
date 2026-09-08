require 'buildsystems/meson'

class Gegl < Meson
  description 'GEGL (Generic Graphics Library) is a data flow based image processing framework, providing floating point processing and non-destructive image processing capabilities to GNU Image Manipulation Program and other projects.'
  homepage 'https://gegl.org/'
  version '0.4.72'
  license 'GPL-3+ and LGPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gegl.git'
  git_hashtag "GEGL_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '650d46ca039e0533d953382548168c67f72e6d3973029e0eef8fff84cef5ea3f',
     armv7l: '650d46ca039e0533d953382548168c67f72e6d3973029e0eef8fff84cef5ea3f',
     x86_64: 'e57a7b6cb0b5f9e387a15b72000e16625347969a2866a17d9fbebc147d2045cf'
  })

  depends_on 'babl' => :library
  depends_on 'cairo' => :library
  depends_on 'enscript' => :build
  depends_on 'ffmpeg' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'gdk_pixbuf' => :library
  depends_on 'gexiv2' => :build
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'graphviz' => :build # for dot
  depends_on 'harfbuzz' => :library
  depends_on 'jasper' => :library
  depends_on 'json_glib' => :library
  depends_on 'lcms' => :library
  depends_on 'lensfun' => :build
  depends_on 'libjpeg_turbo' => :library
  depends_on 'libpng' => :library
  depends_on 'libraw' => :library
  depends_on 'librsvg' => :library
  depends_on 'libspiro' => :library
  depends_on 'libtheora' => :build
  depends_on 'libtiff' => :library
  depends_on 'libwebp' => :library
  depends_on 'luajit' => :build
  depends_on 'openexr' => :library
  depends_on 'pango' => :library
  depends_on 'poppler' => :library
  depends_on 'py3_asciidoc' => :build
  depends_on 'sdl2' => :library
  depends_on 'sdl2_compat' => :library
  depends_on 'sdl3' => :library
  depends_on 'source_highlight' => :build
  depends_on 'suitesparse' => :library
  depends_on 'vala' => :build
  depends_on 'w3m' => :build
  depends_on 'zlib' => :library
end
