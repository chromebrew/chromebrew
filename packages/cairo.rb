require 'buildsystems/meson'
# build order: harfbuzz => freetype => fontconfig => cairo => pango

class Cairo < Meson
  description 'Cairo is a 2D graphics library with support for multiple output devices.'
  homepage 'https://www.cairographics.org'
  version '1.18.6'
  license 'LGPL-2.1 or MPL-1.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/cairo/cairo.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1c284572a7a4f1cc18d7efef7aeb6dae1fb419be4132f9314fe62bd78f39517a',
     armv7l: '1c284572a7a4f1cc18d7efef7aeb6dae1fb419be4132f9314fe62bd78f39517a',
     x86_64: 'a2020d04561c69cb629a5c48fd5e7fa4ed539181b192d8b18219109a168c2282'
  })

  depends_on 'fontconfig' => :library
  depends_on 'freetype' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'harfbuzz' => :build
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
