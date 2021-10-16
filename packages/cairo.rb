require 'package'

class Cairo < Package
  description 'Cairo is a 2D graphics library with support for multiple output devices.'
  homepage 'https://www.cairographics.org'
  version '1.17.4-1'
  license 'LGPL-2.1 or MPL-1.1'
  compatibility 'all'
  source_url 'https://cairographics.org/snapshots/cairo-1.17.4.tar.xz'
  source_sha256 '74b24c1ed436bbe87499179a3b27c43f4143b8676d8ad237a6fa787401959705'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cairo/1.17.4-1_armv7l/cairo-1.17.4-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cairo/1.17.4-1_armv7l/cairo-1.17.4-1-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cairo/1.17.4-1_x86_64/cairo-1.17.4-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '03c6f9c849edf2736de57db8801aea7660d2250d14ed55417bf538ec26ec9787',
     armv7l: '03c6f9c849edf2736de57db8801aea7660d2250d14ed55417bf538ec26ec9787',
     x86_64: '85538c1aac1a7a4cc4061a2b9d94e4dd04f51d9991e102025f145c936b169147'
  })

  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'glib'
  depends_on 'libpng'
  depends_on 'libx11'
  depends_on 'libxcb'
  depends_on 'libxrender'
  depends_on 'lzo'
  depends_on 'mesa'
  depends_on 'pixman'

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    --default-library=both \
    -Dgl-backend=auto \
    -Dglesv3=enabled \
    -Dxlib-xcb=enabled \
    -Dtee=enabled \
    -Dtests=disabled \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
