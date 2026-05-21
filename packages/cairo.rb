require 'buildsystems/meson'
# build order: harfbuzz => freetype => fontconfig => cairo => pango

class Cairo < Meson
  description 'Cairo is a 2D graphics library with support for multiple output devices.'
  homepage 'https://www.cairographics.org'
  version '1.18.4-2'
  license 'LGPL-2.1 or MPL-1.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/cairo/cairo.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ddba0f894e1d252a70e66c24e12cf6d08163b8b574440f287b0bf8249173c2bb',
     armv7l: 'ddba0f894e1d252a70e66c24e12cf6d08163b8b574440f287b0bf8249173c2bb',
     x86_64: 'e0ae01aa2286cd2b69074074ca6ec5981da6d07eb35304003f09ab197cce8f04'
  })

  depends_on 'fontconfig' => :library
  depends_on 'freetype' => :library
  depends_on 'gcc_lib' # R
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'harfbuzz' # R
  depends_on 'libpng' => :library
  depends_on 'libx11' => :library
  depends_on 'libxcb' => :library
  depends_on 'libxrender' => :build
  depends_on 'lzo' => :library
  depends_on 'mesa' => :build
  depends_on 'pixman' => :library
  depends_on 'zlib' => :library

  conflicts_ok # because this overwrites the limited cairo from harfbuzz

  meson_options '-Dxlib-xcb=enabled \
    -Dtests=disabled'
end
