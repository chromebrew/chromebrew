require 'package'

class Cairo < Package
  description 'Cairo is a 2D graphics library with support for multiple output devices.'
  homepage 'https://www.cairographics.org'
  version '1.17.6'
  license 'LGPL-2.1 or MPL-1.1'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/cairo/cairo.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cairo/1.17.6_armv7l/cairo-1.17.6-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cairo/1.17.6_armv7l/cairo-1.17.6-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cairo/1.17.6_i686/cairo-1.17.6-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cairo/1.17.6_x86_64/cairo-1.17.6-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '198bf86fac13ac40cd02b4775bd74cd62bf95c47f4f7e83ac13fe3cf60ad52c4',
     armv7l: '198bf86fac13ac40cd02b4775bd74cd62bf95c47f4f7e83ac13fe3cf60ad52c4',
       i686: '12e9a7fe07745cbcb83d4297888517594b1b96fee4af0711ba903fb6186231f4',
     x86_64: '8d3e0763cc7cd309846fb54f15a3003b6a01efa6fcc5843005e1d6b8137371dd'
  })

  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'glib'
  depends_on 'harfbuzz'
  depends_on 'libx11'
  depends_on 'libxcb'
  depends_on 'libxrender'
  depends_on 'lzo'
  depends_on 'mesa'
  depends_on 'pixman'
  conflicts_ok # because this overwrites the limited cairo from harfbuzz

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
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
