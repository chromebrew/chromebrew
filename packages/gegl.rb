require 'buildsystems/meson'

class Gegl < Meson
  description 'GEGL (Generic Graphics Library) is a data flow based image processing framework, providing floating point processing and non-destructive image processing capabilities to GNU Image Manipulation Program and other projects.'
  homepage 'https://gegl.org/'
  version '0.4.70'
  license 'GPL-3+ and LGPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gegl.git'
  git_hashtag "GEGL_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0f985bd32c2993ca0c9415867ad10f94544b7bb62e3d7d79cfd0dfe219124e0f',
     armv7l: '0f985bd32c2993ca0c9415867ad10f94544b7bb62e3d7d79cfd0dfe219124e0f',
     x86_64: '4f0b84341e743b588fc84386ab03efff927c1a98b522f63bd29c923a57593083'
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
  depends_on 'source_highlight' => :build
  depends_on 'suitesparse' => :library
  depends_on 'vala' => :build
  depends_on 'w3m' => :build
  depends_on 'zlib' => :library
end
