require 'buildsystems/meson'

class Cairo < Meson
  description 'Cairo is a 2D graphics library with support for multiple output devices.'
  homepage 'https://www.cairographics.org'
  version '1.18.1-43e08ae'
  license 'LGPL-2.1 or MPL-1.1'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.freedesktop.org/cairo/cairo.git'
  git_hashtag '43e08aed8b70655d7e5834e81fa87fd353e27e1c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a62399b2399be1666777e3840ddb61e0f3f7295f67f63bfac88c62d7b0bff964',
     armv7l: 'a62399b2399be1666777e3840ddb61e0f3f7295f67f63bfac88c62d7b0bff964',
     x86_64: 'a979754d2b6d6ad19fa0454032b6cdbb53184f315f52b5f8eab86e4cf2e77291'
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
