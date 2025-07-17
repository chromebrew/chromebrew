require 'buildsystems/meson'
# build order: harfbuzz => freetype => fontconfig => cairo => pango

class Cairo < Meson
  description 'Cairo is a 2D graphics library with support for multiple output devices.'
  homepage 'https://www.cairographics.org'
  version '1.18.4'
  license 'LGPL-2.1 or MPL-1.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/cairo/cairo.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e640a24226ef7ddab47d799dfef8606594f18759a3cad5cd17ceae4b3ed54168',
     armv7l: 'e640a24226ef7ddab47d799dfef8606594f18759a3cad5cd17ceae4b3ed54168',
     x86_64: '5ad71a18ae15d987e5cf0565a946a9b384bd2f8ada5df67a4e6630d80ae9e050'
  })

  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'harfbuzz' # R
  depends_on 'libpng' # R
  depends_on 'libx11' # R
  depends_on 'libxcb' # R
  depends_on 'libxrender' # R
  depends_on 'lzo' # R
  depends_on 'mesa' => :build
  depends_on 'pixman' # R
  depends_on 'zlib' # R

  conflicts_ok # because this overwrites the limited cairo from harfbuzz

  meson_options '-Dxlib-xcb=enabled \
    -Dtests=disabled'
end
