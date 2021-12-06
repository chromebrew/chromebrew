require 'package'

class Cairo < Package
  description 'Cairo is a 2D graphics library with support for multiple output devices.'
  homepage 'https://www.cairographics.org'
  version '1.17.5-a047'
  license 'LGPL-2.1 or MPL-1.1'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/cairo/cairo.git'
  git_hashtag 'a04786b9330109ce54bf7f65c7068281419cec6a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cairo/1.17.4-1_armv7l/cairo-1.17.4-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cairo/1.17.4-1_armv7l/cairo-1.17.4-1-chromeos-armv7l.tpxz',
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cairo/1.17.5-a047_i686/cairo-1.17.5-a047-chromeos-i686.tpxz',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cairo/1.17.5-a047_x86_64/cairo-1.17.5-a047-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'd565cf9531e2248dc81df24bf667fb6798d72e92b3db77c86087137b3f63dd03',
     armv7l: 'd565cf9531e2248dc81df24bf667fb6798d72e92b3db77c86087137b3f63dd03',
    i686: 'cc91b1482cf26d5eb23b88225f644f364e721c5fabe213a132da88444c13ade4',
  x86_64: '9d24a1127d2d7103a0be565bf773c8f49952524c53b8a17c356ea30b213b911c'
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
