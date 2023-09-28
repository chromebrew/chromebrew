require 'buildsystems/meson'

class Cairo < Meson
  description 'Cairo is a 2D graphics library with support for multiple output devices.'
  homepage 'https://www.cairographics.org'
  version '1.18.0'
  license 'LGPL-2.1 or MPL-1.1'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.freedesktop.org/cairo/cairo.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cairo/1.18.0_armv7l/cairo-1.18.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cairo/1.18.0_armv7l/cairo-1.18.0-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cairo/1.18.0_x86_64/cairo-1.18.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd72e3793ff72a3f368d159b719522a9f832438caf816437214e359b0e5d4c2af',
     armv7l: 'd72e3793ff72a3f368d159b719522a9f832438caf816437214e359b0e5d4c2af',
     x86_64: '79cb19209eaeabc0f7fd49b4e73c38cae590d4f7e170ebe69b77c085657717ec'
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
