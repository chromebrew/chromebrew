require 'buildsystems/meson'

class Cairo < Meson
  description 'Cairo is a 2D graphics library with support for multiple output devices.'
  homepage 'https://www.cairographics.org'
  version '1.18.1-27c8ad5'
  license 'LGPL-2.1 or MPL-1.1'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.freedesktop.org/cairo/cairo.git'
  git_hashtag '27c8ad5cd8591db742dbf2000ca0d2b08b2c3675'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b3f20a3551db00c8054a648f4b9efdd06becac58f4e95806e17f959a279c07ab',
     armv7l: 'b3f20a3551db00c8054a648f4b9efdd06becac58f4e95806e17f959a279c07ab',
     x86_64: '9f432c84a29a7de5eb6014b911eeb58fa96cd036ac5c2b57d35d99c07eeedc1c'
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
  depends_on 'zlibpkg' # R

  conflicts_ok # because this overwrites the limited cairo from harfbuzz

  meson_options '-Dxlib-xcb=enabled \
    -Dtests=disabled'
end
